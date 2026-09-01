---
name: skill-router
description: Choisir et enchaîner les skills de la crew pour une analyse, feature, bug, sécurité, migration ou revue. Utiliser au début d’un travail multi-étapes.
argument-hint: Décris l’objectif et le type de travail si tu le connais
user-invocable: true
---

# Skill Router

Lis [le catalogue](../../../docs/crew/SKILL_CATALOG.md), puis classe la demande dans une chaîne.

| Type | Chaîne |
| --- | --- |
| Analyse | `work-item-manager` → `repository-analysis` |
| Feature | `work-item-manager` → `repository-analysis` → `feature-delivery` → `change-review` |
| Bug | `work-item-manager` → `bug-triage` → `change-review` |
| Sécurité | `work-item-manager` → `repository-analysis` → `security-review` → `change-review` |
| Migration | `work-item-manager` → `repository-analysis` → `database-migration` → `security-review` → `change-review` |
| Revue | `work-item-manager` → `change-review` |
| SaaS | `work-item-manager` → `repository-analysis` → `saas-toolkit` → `change-review` |
| Mobile | `work-item-manager` → `repository-analysis` → `mobile-toolkit` → `change-review` |
| Hybride | `work-item-manager` → `repository-analysis` → `saas-toolkit` → `mobile-toolkit` → `change-review` |

Annonce la chaîne choisie et la raison. Commence par `work-item-manager`, puis applique `artifact-contract` avec chaque skill produisant une sortie durable. Charge le premier skill, applique sa sortie, puis passe au suivant seulement lorsque ses préconditions sont remplies. Toute étape marquée `[DECISION REQUIRED]` suspend la chaîne jusqu’à une décision explicite de l’utilisateur. Pour un changement sensible, ajoute toujours `security-review` avant la clôture.
