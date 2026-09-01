---
name: work-item-manager
description: Créer, sélectionner et mettre à jour le dossier unique et le manifest d’un travail de la crew. Utiliser au début et à la fin de tout travail non trivial.
argument-hint: Décris l’objectif du travail ou indique son identifiant
user-invocable: true
---

# Gestionnaire de work item

Lis [le contrat d’artéfacts](../../../docs/crew/ARTIFACT_CONTRACT.md).

## Démarrer

1. Cherche un work item existant correspondant à la demande dans `docs/work-items/`.
2. S’il existe, lis son manifest et réutilise son identifiant.
3. Sinon, crée `docs/work-items/WI-AAAA-NNN-slug/` à partir du template. `AAAA` est l’année courante, `NNN` est le prochain numéro disponible et `slug` est une description courte en kebab-case.
4. Renseigne dans le manifest : `id`, `title`, `status`, `owner`, objectif, chaîne de skills et validations requises.
5. Retourne toujours `work_item_id`, `work_item_path` et `manifest_path` à Captain et au skill suivant.

## Mettre à jour

1. Après chaque skill, ajoute ou mets à jour son entrée dans `skills.completed` ou `skills.pending`.
2. Ajoute chaque sortie durable à `artifacts` avec `path`, `type` et `producer`.
3. Ajoute les ADR ou DEC concernés à `decisions`.
4. À la clôture, renseigne `status: verified` seulement après les validations et la revue.

Ne crée pas de dossier de travail pour une simple réponse conversationnelle qui ne produit aucun livrable durable.
