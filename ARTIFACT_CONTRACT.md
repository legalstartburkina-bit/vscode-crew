# Contrat d’artéfacts de la crew

## Règle fondamentale

Toute sortie durable produite par un skill appartient à un work item et doit être déclarée dans son `manifest.yaml`. Aucun skill ne crée de note, rapport ou plan durable ailleurs sans une décision explicite de l’utilisateur.

## Emplacements autorisés

| Type de donnée | Emplacement |
| --- | --- |
| Travail ponctuel : analyse, bug, audit, revue, migration | `docs/work-items/<id>/` |
| Fonctionnalité autorisée | `docs/specs/<feature>/` |
| Décision durable humaine | `docs/adr/` |
| Décision structurée | `docs/decisions/` |
| Documentation de fonctionnement de la crew | `docs/crew/` |
| Contexte, état ou leçon de la crew | `.crew/` |

## Cycle des données

1. `work-item-manager` crée ou sélectionne un work item et son manifest.
2. Chaque skill reçoit l’identifiant et le chemin du work item.
3. Le skill dépose son rapport dans ce dossier, puis ajoute ce chemin à `artifacts` dans le manifest.
4. Les décisions importantes sont référencées dans `decisions` ; elles restent écrites dans `docs/adr/` ou `docs/decisions/`.
5. `change-review` vérifie que les fichiers présents et le manifest concordent avant le verdict.

## Interdictions

- Ne pas créer de fichier durable à la racine du dépôt.
- Ne pas créer de notes parallèles dans plusieurs dossiers pour le même travail.
- Ne pas stocker de secret, token, mot de passe ou donnée personnelle sensible dans un artéfact.
- Ne pas considérer un artéfact comme livré s’il n’est pas enregistré dans le manifest.

## Contrôle technique

Le hook de la crew refuse les créations ou modifications d’artéfacts de pilotage reconnaissables (`analysis`, `audit`, `review`, `report`, `notes`, `plan`, `triage`, `migration`, `manifest`, `decision`) hors des emplacements autorisés. Il ne remplace pas la revue du manifest : il est un filet de sécurité, pas une méthode de classement.
