[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$Workspace,
    
    [ValidateSet('Local', 'GitHub')]
    [string]$From = 'Local',
    
    [string]$GitHubOwner = 'legalstartburkina-bit',
    [string]$GitHubRepo = 'vscode-crew',
    [string]$Branch = 'main',
    [string]$Tag,
    
    [switch]$Force,
    [switch]$InitializeProtocol
)

$ErrorActionPreference = 'Stop'
$tempDir = $null

trap {
    if ($tempDir -and (Test-Path -LiteralPath $tempDir)) {
        Remove-Item -LiteralPath $tempDir -Recurse -Force -ErrorAction SilentlyContinue
    }
    throw
}

function New-CrewTemporaryDirectory {
    $path = Join-Path ([System.IO.Path]::GetTempPath()) ("vscode-crew-" + [Guid]::NewGuid().ToString('N'))
    New-Item -ItemType Directory -Path $path -Force | Out-Null
    return $path
}

# Déterminer la source : locale ou GitHub
if ($From -eq 'GitHub') {
    Write-Host "Téléchargement depuis GitHub ($GitHubOwner/$GitHubRepo)..." -ForegroundColor Cyan
    
    # Construire l'URL de release
    if ($Tag) {
        $releaseUrl = "https://github.com/$GitHubOwner/$GitHubRepo/archive/refs/tags/$Tag.zip"
        Write-Host "Version : $Tag"
    } else {
        $releaseUrl = "https://github.com/$GitHubOwner/$GitHubRepo/archive/refs/heads/$Branch.zip"
        Write-Host "Branche : $Branch"
    }
    
    # Créer un dossier temporaire
    $tempDir = New-CrewTemporaryDirectory
    $zipPath = Join-Path $tempDir "repo.zip"
    
    try {
        # Télécharger
        Write-Host "Téléchargement en cours..."
        $ProgressPreference = 'SilentlyContinue'
        Invoke-WebRequest -Uri $releaseUrl -OutFile $zipPath -ErrorAction Stop
        if ($Sha256) {
            $actualHash = (Get-FileHash -LiteralPath $zipPath -Algorithm SHA256).Hash
            if ($actualHash -ine $Sha256) {
                throw "Le SHA-256 de l'archive ne correspond pas à -Sha256."
            }
            Write-Host "Intégrité SHA-256 vérifiée" -ForegroundColor Green
        }
        
        # Décompresser
        Write-Host "Extraction en cours..."
        Expand-Archive -Path $zipPath -DestinationPath $tempDir -Force
        
        # Trouver le dossier racine décompressé
        $extractedDir = Get-ChildItem -Path $tempDir -Directory | Where-Object { $_.Name -match "vscode-crew" } | Select-Object -First 1
        if (-not $extractedDir) {
            throw "Impossible de trouver le dossier vscode-crew après extraction."
        }
        $source = $extractedDir.FullName
        Write-Host "Extraction réussie : $source"
    } catch {
        throw "Erreur lors du téléchargement/extraction : $_"
    }
} else {
    $source = $PSScriptRoot
    Write-Host "Mode local : $source" -ForegroundColor Cyan
}

$target = (Resolve-Path -LiteralPath $Workspace).Path

# Les dossiers peuvent déjà exister dans un projet utilisateur. La copie
# refuse les collisions de fichiers sans -Force, au lieu de refuser tout le
# dossier parent.
$items = @('.github/agents', '.github/skills', '.github/hooks', 'docs/crew')

# Initialiser le protocole (work-items, ADR, specs)
if ($InitializeProtocol) {
    $initScript = Join-Path $source 'initialize-project.ps1'
    if (Test-Path -LiteralPath $initScript) {
        Write-Host "Initialisation du protocole..." -ForegroundColor Cyan
        & $initScript -Workspace $target -Force:$Force -WhatIf:$WhatIfPreference
    } else {
        Write-Warning "initialize-project.ps1 non trouvé."
    }
}

# Copier les fichiers
Write-Host "Installation de la crew..." -ForegroundColor Cyan
foreach ($item in $items) {
    $from = Join-Path $source $item
    $to = Join-Path $target $item
    
    if (-not (Test-Path -LiteralPath $from)) {
        Write-Warning "Source non trouvée : $from"
        continue
    }
    
    if ($PSCmdlet.ShouldProcess($to, "Installer $item")) {
        New-Item -ItemType Directory -Force -Path $to | Out-Null
        Copy-Item -Path (Join-Path $from '*') -Destination $to -Recurse -Force:$Force
        Write-Host "✓ $item installé"
    }
}

# Nettoyer le dossier temporaire
if ($From -eq 'GitHub' -and $tempDir -and (Test-Path -LiteralPath $tempDir)) {
    Remove-Item -LiteralPath $tempDir -Recurse -Force
    $tempDir = $null
}

if (-not $WhatIfPreference) {
    Write-Host "`n✅ Crew installée dans $target" -ForegroundColor Green
    Write-Host "Prochaines étapes :" -ForegroundColor Cyan
    Write-Host "  1. Ouvrir VS Code sur le projet"
    Write-Host "  2. Chat: Open Customizations → Vérifier les 5 agents"
    Write-Host "  3. Chat: Manage Language Models → Connecter DeepSeek si nécessaire"
    Write-Host "  4. Utiliser /skill-router pour la première chaîne de travail`n" -ForegroundColor Cyan
}
