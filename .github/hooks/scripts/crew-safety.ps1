$ErrorActionPreference = 'Stop'

try {
    $rawPayload = [Console]::In.ReadToEnd()
    if ([string]::IsNullOrWhiteSpace($rawPayload)) {
        $rawPayload = ($input | Out-String)
    }
    $payload = $rawPayload | ConvertFrom-Json
    $command = [string]$payload.tool_input.command

    # Les livrables de la crew suivent un contrat unique. Ce contrôle ne limite
    # pas le code applicatif ; il bloque seulement les rapports et données de
    # pilotage créés hors des répertoires prévus.
    $allowedCrewPaths = '^(?:\.crew/|docs/(?:work-items/[^/]+/|specs/[^/]+/|adr/|decisions/))'
    $allowedRootDocs = '^(?:README|CHANGELOG|CONTRIBUTING|LICENSE)(?:\.[^/]+)?$'
    $reportNames = '(?i)(?:^|/)(?:analysis|audit|review|report|notes?|plan|triage|migration|manifest|decision)(?:[-_a-z0-9]*)?\.(?:md|ya?ml|json)$'
    $paths = @()
    if ($payload.tool_input.files) {
        $paths += @($payload.tool_input.files | ForEach-Object { [string]$_.path })
    }
    if ($payload.tool_input.path) {
        $paths += [string]$payload.tool_input.path
    }
    foreach ($path in $paths) {
        $normalPath = $path.Replace('\', '/').TrimStart('./')
        if ($normalPath -match $reportNames -and $normalPath -notmatch $allowedCrewPaths -and $normalPath -notmatch $allowedRootDocs) {
            @{ hookSpecificOutput = @{ permissionDecision = 'deny'; permissionDecisionReason = "Artéfact de crew refusé hors emplacement autorisé : $path. Utilise work-item-manager et docs/work-items/<id>/manifest.yaml." } } | ConvertTo-Json -Compress
            exit 0
        }
    }

    $blocked = @(
        '(?i)\brm\s+-rf\s+[/~]',
        '(?i)\bdel\s+/[fsq]+\s+[a-z]:\\',
        '(?i)\bformat\s+[a-z]:',
        '(?i)\bgit\s+push\s+.*--force',
        '(?i)\b(drop|truncate)\s+(database|table)\b',
        '(?i)\b(curl|wget)\b.*\|\s*(sh|bash|powershell)',
        '(?i)\b(aws|az|gcloud)\b.*\b(delete|destroy|terminate)\b'
    )

    foreach ($pattern in $blocked) {
        if ($command -match $pattern) {
            @{ hookSpecificOutput = @{ permissionDecision = 'deny'; permissionDecisionReason = 'Commande bloquée par la crew : action destructive ou exécution distante détectée.' } } | ConvertTo-Json -Compress
            exit 0
        }
    }

    @{ continue = $true } | ConvertTo-Json -Compress
}
catch {
    @{ continue = $true } | ConvertTo-Json -Compress
}
