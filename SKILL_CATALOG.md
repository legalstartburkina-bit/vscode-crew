# Catalogue des skills de la crew

Tous ces skills sont disponibles pour les agents du projet depuis `.github/skills/`. Installe-les dans `~/.copilot/skills/` avec `install-skill.ps1` pour les utiliser dans tous les projets VS Code.

| Skill | À utiliser quand | Chaîne suivante |
| --- | --- | --- |
| `work-item-manager` | Créer ou reprendre le dossier et manifest d’un travail. | Le premier skill métier de la chaîne. |
| `artifact-contract` | Appliquer les emplacements de sortie et mettre à jour le manifest. | Utilisé avec chaque skill. |
| `toolkit-config` | Lire ou initialiser la configuration d’équipe sans secrets. | `saas-toolkit` ou `mobile-toolkit`. |
| `saas-toolkit` | Coordonner un changement SaaS. | Contrats, tenancy, sécurité, livraison. |
| `mobile-toolkit` | Coordonner un changement mobile. | Développement, qualité, sécurité, release. |
| `repository-analysis` | Comprendre un dépôt ou préparer un cadrage. | `feature-delivery` ou `bug-triage` selon le besoin. |
| `feature-delivery` | Ajouter ou modifier une fonctionnalité. | `change-review`, puis `security-review` si sensible. |
| `bug-triage` | Reproduire, localiser et corriger un bug. | `change-review`. |
| `security-review` | Authentification, secrets, permissions, données ou déploiement. | `change-review` ou décision utilisateur. |
| `database-migration` | Toute évolution de schéma ou migration de données. | `security-review`, puis `change-review`. |
| `change-review` | Examiner un diff ou clôturer une implémentation. | Retour à Captain pour le verdict. |
| `skill-router` | Choisir et enchaîner les skills pour une demande. | Lance la chaîne adaptée. |

## Chaînes prêtes à l’emploi

```text
Analyse : work-item-manager → repository-analysis
Feature : work-item-manager → repository-analysis → feature-delivery → change-review
Bug : work-item-manager → bug-triage → change-review
Sécurité : work-item-manager → repository-analysis → security-review → change-review
Migration : work-item-manager → repository-analysis → database-migration → security-review → change-review
Revue : work-item-manager → change-review
SaaS : work-item-manager → repository-analysis → saas-toolkit → change-review
Mobile : work-item-manager → repository-analysis → mobile-toolkit → change-review
Hybride : work-item-manager → repository-analysis → saas-toolkit → mobile-toolkit → change-review
```

Le passage d’un skill à l’autre est une instruction d’orchestration menée par Captain ; les boutons de handoff de VS Code relient les agents, pas les skills. Pour une invocation directe, utilise `/skill-router`, puis indique ton objectif.
