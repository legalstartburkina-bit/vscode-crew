[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$Workspace,
    [switch]$Force,
    [switch]$InitializeProtocol
)

$ErrorActionPreference = 'Stop'
$source = $PSScriptRoot
$target = (Resolve-Path -LiteralPath $Workspace).Path

$items = @('.github/agents', '.github/skills', '.github/hooks', 'docs/crew')
foreach ($item in $items) {
    $destination = Join-Path $target $item
    if ((Test-Path -LiteralPath $destination) -and -not $Force) {
        throw "La destination existe déjà : $destination. Relance avec -Force après vérification."
    }
}

if ($InitializeProtocol) {
    & (Join-Path $source 'initialize-project.ps1') -Workspace $target -Force:$Force -WhatIf:$WhatIfPreference
}

foreach ($item in $items) {
    $from = Join-Path $source $item
    $to = Join-Path $target $item
    if ($PSCmdlet.ShouldProcess($to, "Installer $item")) {
        New-Item -ItemType Directory -Force -Path (Split-Path -Parent $to) | Out-Null
        Copy-Item -LiteralPath $from -Destination $to -Recurse -Force:$Force
    }
}

if (-not $WhatIfPreference) {
    Write-Host "Crew installée dans $target"
    Write-Host "Dans VS Code : Chat: Open Customizations, puis active les hooks si nécessaire."
}
