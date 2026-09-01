[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$SkillPath,
    [ValidateSet('Personal', 'Workspace')]
    [string]$Scope = 'Personal',
    [string]$Workspace,
    [switch]$Force
)

$ErrorActionPreference = 'Stop'
$source = (Resolve-Path -LiteralPath $SkillPath).Path
if (-not (Test-Path -LiteralPath $source -PathType Container)) {
    throw "Le skill doit être un dossier : $SkillPath"
}

$skillFile = Join-Path $source 'SKILL.md'
if (-not (Test-Path -LiteralPath $skillFile -PathType Leaf)) {
    throw "SKILL.md est introuvable dans : $source"
}

$content = Get-Content -LiteralPath $skillFile -Raw
if ($content -notmatch '(?s)^---\s*\r?\n(.*?)\r?\n---') {
    throw "SKILL.md doit commencer par un frontmatter YAML."
}
$frontmatter = $Matches[1]
$nameMatch = [regex]::Match($frontmatter, '(?m)^name:\s*([a-z0-9-]+)\s*$')
if (-not $nameMatch.Success) {
    throw "Le frontmatter doit contenir un nom en kebab-case."
}
$skillName = $nameMatch.Groups[1].Value
if ((Split-Path -Leaf $source) -cne $skillName) {
    throw "Le dossier '$((Split-Path -Leaf $source))' doit porter le même nom que le skill '$skillName'."
}

if ($Scope -eq 'Personal') {
    $profileRoot = [Environment]::GetFolderPath('UserProfile')
    $destinationRoot = Join-Path $profileRoot '.copilot\skills'
}
else {
    if ([string]::IsNullOrWhiteSpace($Workspace)) {
        throw "-Workspace est requis lorsque -Scope Workspace est choisi."
    }
    $workspaceRoot = (Resolve-Path -LiteralPath $Workspace).Path
    $destinationRoot = Join-Path $workspaceRoot '.github\skills'
}

$destination = Join-Path $destinationRoot $skillName
if ((Test-Path -LiteralPath $destination) -and -not $Force) {
    throw "Le skill existe déjà : $destination. Vérifie-le puis utilise -Force si nécessaire."
}

if ($PSCmdlet.ShouldProcess($destination, "Installer le skill $skillName")) {
    New-Item -ItemType Directory -Force -Path $destinationRoot | Out-Null
    Copy-Item -LiteralPath $source -Destination $destination -Recurse -Force:$Force
}

if (-not $WhatIfPreference) {
    Write-Host "Skill '$skillName' installé dans $destination"
}
