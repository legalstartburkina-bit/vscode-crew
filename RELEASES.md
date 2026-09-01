# VS Code Crew — Releases

## v1.0.0 (2026-09-01) — Initial Release

### ✨ Nouveautés
- **5 agents** orchestrés : Captain, Architect, Builder, Reviewer, Security
- **20 skills** réutilisables couvrant :
  - Gestion de travail : `work-item-manager`
  - Analyse : `repository-analysis`, `skill-router`
  - Fonctionnalités : `feature-delivery`, `artifact-contract`
  - Bugs : `bug-triage`
  - Sécurité : `security-review`, `saas-multitenancy`, `safe-change`
  - Mobile : `mobile-development`, `mobile-quality`, `mobile-release-readiness`, `mobile-toolkit`
  - SaaS : `saas-api-contracts`, `saas-toolkit`, `saas-release-readiness`
  - Base de données : `database-migration`
  - Revue : `change-review`
  - Configuration : `toolkit-config`
  - Workflow : `crew-workflow`
- **Protocole** : ADR, spécifications, work-items avec traçabilité complète
- **Hooks de sécurité** : Bloque opérations risquées et artéfacts mal placés
- **Scripts d'installation** : Mode local et GitHub (vérification en cours)

### 📥 Installation

#### Mode local (depuis le dépôt cloné)
```powershell
Set-Location "chemin\vers\vscode-crew"
.\install.ps1 -Workspace "C:\Mon-Projet" -InitializeProtocol
```

#### Mode GitHub (recommandé pour distribution)
```powershell
# Installer depuis la branche main
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/legalstartburkina-bit/vscode-crew/main/install.ps1" -OutFile "install.ps1"
.\install.ps1 -Workspace "C:\Mon-Projet" -From GitHub -Branch main -InitializeProtocol

# Ou depuis une version stable (v1.0.0)
.\install.ps1 -Workspace "C:\Mon-Projet" -From GitHub -Tag v1.0.0 -InitializeProtocol
```

#### Installation des skills personnellement (réutilisables dans tous projets)
```powershell
# Chaque skill individuellement
$repo = "https://github.com/legalstartburkina-bit/vscode-crew"
$skillNames = @("bug-triage", "feature-delivery", "security-review", "change-review")
foreach ($skill in $skillNames) {
    Invoke-WebRequest -Uri "$repo/raw/main/install-skill.ps1" -OutFile "install-skill.ps1"
    .\install-skill.ps1 -SkillPath ".\skill\$skill" -Scope Personal -From GitHub -Tag v1.0.0
}
```

### ⚠️ Notes
- Secrets et API keys : jamais dans le dépôt ; utiliser le prompt sécurisé VS Code
- `.gitignore` : exclus `*.secret`, `deepseek.chatLanguageModels.*.json`, `.env`
- Branche par défaut : `main` (stable)
- Disponible sous licence MIT (à ajouter)

### 🐛 Problèmes connus
- Mode GitHub (`-From GitHub`) en attente de validation des scripts
- Fin de ligne CRLF vs LF (avertissements non bloquants)

---

## Roadmap v1.1.0 (prochain)
- [ ] Validation scripts `-From GitHub`
- [ ] GitHub Actions pour CI/CD
- [ ] Support des dépendances (npm, pip)
- [ ] Observabilité améliorée (logs structurés)
