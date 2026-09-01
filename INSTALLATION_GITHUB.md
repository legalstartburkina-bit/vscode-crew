# Installation depuis GitHub

Le dépôt VS Code Crew est maintenant disponible sur GitHub : **https://github.com/legalstartburkina-bit/vscode-crew**

## 📥 Installation rapide (recommandée)

Prérequis : Windows avec PowerShell 5.1 ou PowerShell 7, un workspace déjà créé et VS Code à jour. Le mode GitHub télécharge une archive du tag ou de la branche choisie ; pour une installation de production, préférez un tag immuable et vérifiez la provenance du dépôt avant exécution.

### 1️⃣ Installation globale (toutes les sessions VS Code)

```powershell
# Télécharger et exécuter le script d'installation depuis main
$repo = "https://raw.githubusercontent.com/legalstartburkina-bit/vscode-crew/main"
$installScript = "$repo/install.ps1"

Invoke-WebRequest -Uri $installScript -OutFile "install.ps1"
.\install.ps1 -Workspace "C:\Mon-Projet" -From GitHub -InitializeProtocol
```

### 2️⃣ Installation d'une version stable (v1.0.0)

```powershell
# Depuis le tag v1.0.0
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/legalstartburkina-bit/vscode-crew/v1.0.0/install.ps1" -OutFile "install.ps1"
.\install.ps1 -Workspace "C:\Mon-Projet" -From GitHub -Tag v1.0.0 -InitializeProtocol
```

### 3️⃣ Installation des skills personnellement (disponibles partout)

```powershell
# Télécharger le script d'installation des skills
$repo = "https://raw.githubusercontent.com/legalstartburkina-bit/vscode-crew/main"
Invoke-WebRequest -Uri "$repo/install-skill.ps1" -OutFile "install-skill.ps1"

# Installer un skill directement depuis GitHub
.\install-skill.ps1 -SkillName "bug-triage" -Scope Personal -From GitHub
.\install-skill.ps1 -SkillName "feature-delivery" -Scope Personal -From GitHub -Tag v1.0.0
```

## 🔄 Mise à jour existante

Si vous avez déjà installé la crew localement et souhaitez passer à GitHub :

```powershell
# Méthode 1 : Réinstaller dans un nouveau projet
$repo = "https://raw.githubusercontent.com/legalstartburkina-bit/vscode-crew/main"
Invoke-WebRequest -Uri "$repo/install.ps1" -OutFile "install.ps1"
.\install.ps1 -Workspace "C:\Nouveau-Projet" -From GitHub

# Méthode 2 : Créer un script de sync pour les projets existants
# Ajouter ceci dans votre projet : .crew/sync-crew.ps1
```

## 📦 Paramètres disponibles

### `install.ps1`

```powershell
# Mode local (depuis le dossier cloné)
.\install.ps1 -Workspace "C:\Projet" -From Local -InitializeProtocol

# Mode GitHub (recommandé - télécharge automatiquement)
.\install.ps1 -Workspace "C:\Projet" -From GitHub -Branch main -InitializeProtocol

# Version spécifique avec contrôle d'intégrité optionnel
.\install.ps1 -Workspace "C:\Projet" -From GitHub -Tag v1.0.0 -Sha256 "<SHA256_DE_L_ARCHIVE>" -InitializeProtocol

# Forcer la réinstallation (attention : écrase les existants)
.\install.ps1 -Workspace "C:\Projet" -From GitHub -Force
```

### `install-skill.ps1`

```powershell
# Installer depuis un chemin local
.\install-skill.ps1 -SkillPath "C:\chemin\vers\skill" -Scope Personal

# Installer directement depuis GitHub (nom du skill)
.\install-skill.ps1 -SkillName "bug-triage" -Scope Personal -From GitHub

# Version spécifique
.\install-skill.ps1 -SkillName "bug-triage" -Scope Personal -From GitHub -Tag v1.0.0

# Dans un workspace spécifique
.\install-skill.ps1 -SkillName "bug-triage" -Scope Workspace -Workspace "C:\Projet" -From GitHub
```

## 🎯 Cas d'usage

### Nouvelle machine sans rien
```powershell
cd C:\Temp
$repo = "https://raw.githubusercontent.com/legalstartburkina-bit/vscode-crew/main"
Invoke-WebRequest -Uri "$repo/install.ps1" -OutFile "install.ps1"
.\install.ps1 -Workspace "C:\Projets\MonProjet" -From GitHub -InitializeProtocol
```

### Installer tous les skills personnellement (1 fois pour tous les projets)
```powershell
$repo = "https://raw.githubusercontent.com/legalstartburkina-bit/vscode-crew/main"
Invoke-WebRequest -Uri "$repo/install-skill.ps1" -OutFile "install-skill.ps1"

$skills = @("bug-triage", "feature-delivery", "change-review", "security-review", "repository-analysis")
foreach ($skill in $skills) {
    .\install-skill.ps1 -SkillName $skill -Scope Personal -From GitHub
    Write-Host "✓ $skill installé"
}
```

### Mettre à jour un projet existant à v1.1.0 (futur)
```powershell
cd "C:\Projets\MonProjet"
$repo = "https://raw.githubusercontent.com/legalstartburkina-bit/vscode-crew/main"
Invoke-WebRequest -Uri "$repo/install.ps1" -OutFile "install.ps1"
.\install.ps1 -From GitHub -Tag v1.1.0 -Force
```

## ✅ Vérifier l'installation

Une fois installé, dans **VS Code** :

1. **Chat: Open Customizations** → Vous devez voir les 5 agents :
   - Captain
   - Architect
   - Builder
   - Reviewer
   - Security

2. **Chat: Manage Language Models** → Connecter DeepSeek si nécessaire

3. Taper `/skill-router` dans le chat pour lister tous les skills disponibles

## 🆘 Troubleshooting

### "Impossible de résoudre le chemin"
```powershell
# Vérifier que le chemin du projet existe
Test-Path "C:\Mon-Projet"
```

### "SKILL.md est introuvable"
Vérifier que le skill existe sur GitHub :
```powershell
$skillName = "bug-triage"
$url = "https://raw.githubusercontent.com/legalstartburkina-bit/vscode-crew/main/.github/skills/$skillName/SKILL.md"
Invoke-WebRequest -Uri $url -UseBasicParsing | Select-Object -ExpandProperty StatusCode
```

### Activation des hooks
Dans VS Code, aller à **Settings** → Chercher `hook` → Activer si disponible.

## 📚 Documentation supplémentaire

- [README.md](README.md) - Vue d'ensemble et utilisation recommandée
- [RELEASES.md](RELEASES.md) - Historique des versions
- [PROTOCOL.md](PROTOCOL.md) - Protocole de travail de la crew
- [SKILL_CATALOG.md](SKILL_CATALOG.md) - Catalogue complet des skills
- [ARTIFACT_CONTRACT.md](ARTIFACT_CONTRACT.md) - Contrat de stockage des artefacts

## 🔗 Références

- **Dépôt GitHub** : https://github.com/legalstartburkina-bit/vscode-crew
- **Issues & PRs** : Pour signaler des bugs ou proposer des améliorations
- **Releases** : https://github.com/legalstartburkina-bit/vscode-crew/releases
