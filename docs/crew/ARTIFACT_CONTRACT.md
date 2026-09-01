# Contrat d’artéfacts de la crew

Toute sortie durable appartient à un work item et est déclarée dans `docs/work-items/<id>/manifest.yaml`.

| Type de donnée | Emplacement |
| --- | --- |
| Analyse, bug, audit, revue, migration | `docs/work-items/<id>/` |
| Spécification de fonctionnalité | `docs/specs/<feature>/` |
| Décision durable | `docs/adr/` et `docs/decisions/` |
| Documentation de fonctionnement de la crew | `docs/crew/` |
| Contexte et état de la crew | `.crew/` |

Chaque skill ajoute ses artéfacts, décisions et validations au manifest. Le hook bloque les rapports de pilotage créés hors de ces emplacements.
