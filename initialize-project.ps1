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
    if ((Test-Path -LiteralPath $destination) -and -not $Force) {
        throw "La destination existe déjà : $destination. Relance avec -Force seulement après vérification."
    }
}
foreach ($item in $items) {
    $from = Join-Path $source $item
    $to = Join-Path $target $item
    if ($PSCmdlet.ShouldProcess($to, "Initialiser $item")) {
        New-Item -ItemType Directory -Force -Path (Split-Path -Parent $to) | Out-Null
        Copy-Item -LiteralPath $from -Destination $to -Recurse -Force:$Force
    }
}
if (-not $WhatIfPreference) { Write-Host "Protocole initialisé dans $target" }
