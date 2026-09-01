# Protocole de la VS Code DeepSeek Crew

## Autorité des informations

En cas de contradiction, applique cet ordre : décision explicite de l'utilisateur, ADR accepté, contrat ou invariant, spécification, plan, code, recommandation d'agent, hypothèse du modèle.

Le code est une preuve utile, pas une autorisation de contredire une décision acceptée. Toute exception doit être soumise à l’utilisateur et documentée dans une nouvelle décision qui indique clairement ce qu'elle remplace.

## Cycle de travail

| État | Responsable | Sortie requise |
| --- | --- | --- |
| `INTENT_CAPTURED` | Captain | Objectif et critères d’acceptation. |
| `CONTEXT_READY` | Captain / Architect | Contexte et décisions applicables identifiés. |
| `ANALYSIS_READY` | Architect | Analyse, options, risques et plan. |
| `ARBITRATION_PENDING` | Captain / utilisateur | Choix explicite lorsqu’une décision importante manque. |
| `IMPLEMENTATION_READY` | Captain | Brief, périmètre et validation explicites. |
| `EXECUTING` | Builder | Modifications limitées au brief. |
| `REVIEW_PENDING` | Reviewer / Security | Comparaison entre modifications et autorisation. |
| `VERIFIED` | Captain | Vérifications et résultat final consignés. |

## Règles strictes

- Une spécification ou un plan ne sont pas une autorisation d’implémenter.
- Une question ayant un impact sur l’architecture, la sécurité, les données, les contrats ou le coût est marquée `[DECISION REQUIRED]`.
- Pendant `ARBITRATION_PENDING`, aucun code, contrat ou configuration métier n’est modifié.
- Builder travaille uniquement à partir d’un brief approuvé.
- Reviewer signale toute dérive entre le brief, les ADR et les changements réels.

## Structure initialisée

```text
docs/adr/                 # ADR versionnés
docs/decisions/           # registre machine-readable
docs/specs/<fonctionnalité>/
.crew/context.md          # contexte durable
.crew/project-state.md    # état courant
.crew/lessons.md          # apprentissages
```
