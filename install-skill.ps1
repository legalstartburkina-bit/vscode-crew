[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory, ParameterSetName = 'LocalPath')]
    [ValidateNotNullOrEmpty()]
    [string]$SkillPath,
    
    [Parameter(Mandatory, ParameterSetName = 'GitHubName')]
    [ValidateNotNullOrEmpty()]
    [string]$SkillName,
    
    [ValidateSet('Personal', 'Workspace')]
    [string]$Scope = 'Personal',
    
    [string]$Workspace,
    
    [ValidateSet('Local', 'GitHub')]
    [string]$From = 'Local',
    
    [string]$GitHubOwner = 'legalstartburkina-bit',
    [string]$GitHubRepo = 'vscode-crew',
    [string]$Branch = 'main',
    [string]$Tag,
    
    [switch]$Force
)

$ErrorActionPreference = 'Stop'

# Résoudre le skill
if ($PSCmdlet.ParameterSetName -eq 'LocalPath') {
    $source = (Resolve-Path -LiteralPath $SkillPath).Path
    if (-not (Test-Path -LiteralPath $source -PathType Container)) {
        throw "Le skill doit être un dossier : $SkillPath"
    }
} else {
    # Mode GitHub : télécharger le skill
    Write-Host "Téléchargement du skill depuis GitHub..." -ForegroundColor Cyan
    
    $skillFileName = $SkillName
    if ($From -eq 'GitHub') {
        # Construire l'URL
        if ($Tag) {
            $skillUrl = "https://raw.githubusercontent.com/$GitHubOwner/$GitHubRepo/$Tag/.github/skills/$skillFileName/SKILL.md"
            Write-Host "Skill : $skillFileName (version $Tag)" -ForegroundColor Cyan
        } else {
            $skillUrl = "https://raw.githubusercontent.com/$GitHubOwner/$GitHubRepo/$Branch/.github/skills/$skillFileName/SKILL.md"
            Write-Host "Skill : $skillFileName (branche $Branch)" -ForegroundColor Cyan
        }
        
        # Créer un dossier temporaire
        $tempDir = New-TemporaryDirectory -Name "vscode-crew-skill-temp"
        $source = Join-Path $tempDir $skillFileName
        New-Item -ItemType Directory -Path $source | Out-Null
        
        try {
            # Télécharger le fichier SKILL.md
            Write-Host "Téléchargement de SKILL.md..."
            $skillFile = Join-Path $source 'SKILL.md'
            $ProgressPreference = 'SilentlyContinue'
            Invoke-WebRequest -Uri $skillUrl -OutFile $skillFile -ErrorAction Stop
            
            # Créer un fichier README temporaire pour la validation
            $tempReadme = "# $skillFileName`nTemporary placeholder"
            Set-Content -Path (Join-Path $source 'README.md') -Value $tempReadme
            
            Write-Host "✓ Téléchargement réussi" -ForegroundColor Green
        } catch {
            Remove-Item -Recurse -Force $tempDir
            throw "Erreur lors du téléchargement du skill : $_"
        }
    }
}

# Valider le fichier SKILL.md
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
$extractedSkillName = $nameMatch.Groups[1].Value

# Déterminer le chemin de destination
if ($Scope -eq 'Personal') {
    $profileRoot = [Environment]::GetFolderPath('UserProfile')
    $destinationRoot = Join-Path $profileRoot '.copilot\skills'
} else {
    if ([string]::IsNullOrWhiteSpace($Workspace)) {
        throw "-Workspace est requis lorsque -Scope Workspace est choisi."
    }
    $workspaceRoot = (Resolve-Path -LiteralPath $Workspace).Path
    $destinationRoot = Join-Path $workspaceRoot '.github\skills'
}

$destination = Join-Path $destinationRoot $extractedSkillName
if ((Test-Path -LiteralPath $destination) -and -not $Force) {
    throw "Le skill existe déjà : $destination. Vérifie-le puis utilise -Force si nécessaire."
}

# Installer
Write-Host "Installation du skill '$extractedSkillName'..." -ForegroundColor Cyan
if ($PSCmdlet.ShouldProcess($destination, "Installer le skill $extractedSkillName")) {
    New-Item -ItemType Directory -Force -Path $destinationRoot | Out-Null
    Copy-Item -LiteralPath $source -Destination $destination -Recurse -Force:$Force
}

# Nettoyer
if ($From -eq 'GitHub' -and (Test-Path $tempDir)) {
    Remove-Item -Recurse -Force $tempDir
}

if (-not $WhatIfPreference) {
    Write-Host "✅ Skill '$extractedSkillName' installé" -ForegroundColor Green
    Write-Host "   Emplacement : $destination"
    if ($Scope -eq 'Personal') {
        Write-Host "   Disponible dans tous les projets VS Code" -ForegroundColor Cyan
    }
}
}
