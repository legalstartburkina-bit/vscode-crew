[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)] [string]$Workspace,
    [switch]$Force
)

$ErrorActionPreference = 'Stop'
$source = Join-Path $PSScriptRoot 'protocol-template'
$target = (Resolve-Path -LiteralPath $Workspace).Path
$items = @('docs/adr', 'docs/decisions', 'docs/specs/_template', 'docs/work-items/_template', 'docs/ARTIFACT_CONTRACT.md', '.crew')
foreach ($item in $items) {
    $destination = Join-Path $target $item
    # Les dossiers parents peuvent être partagés avec le projet. Les fichiers
    # existants restent protégés tant que -Force n'est pas demandé.
    if ((Test-Path -LiteralPath $destination -PathType Leaf) -and -not $Force) {
        throw "Le fichier existe déjà : $destination. Relance avec -Force seulement après vérification."
    }
}
foreach ($item in $items) {
    $from = Join-Path $source $item
    $to = Join-Path $target $item
    if ($PSCmdlet.ShouldProcess($to, "Initialiser $item")) {
        if (Test-Path -LiteralPath $from -PathType Container) {
            New-Item -ItemType Directory -Force -Path $to | Out-Null
            Copy-Item -Path (Join-Path $from '*') -Destination $to -Recurse -Force:$Force
        } else {
            New-Item -ItemType Directory -Force -Path (Split-Path -Parent $to) | Out-Null
            Copy-Item -LiteralPath $from -Destination $to -Force:$Force
        }
    }
}
if (-not $WhatIfPreference) { Write-Host "Protocole initialisé dans $target" }
