# Contrat d’artéfacts de la crew

Voir la version distribuée par la crew. Toute sortie durable appartient à un work item déclaré dans `docs/work-items/<id>/manifest.yaml`.

| Type | Emplacement autorisé |
| --- | --- |
| Analyse, bug, audit, revue, migration | `docs/work-items/<id>/` |
| Spécification de fonctionnalité | `docs/specs/<feature>/` |
| ADR / décision | `docs/adr/` et `docs/decisions/` |
| Contexte de la crew | `.crew/` |

Le hook de la crew bloque les rapports de pilotage créés hors de ces emplacements.
