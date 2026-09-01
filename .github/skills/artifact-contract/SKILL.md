---
name: artifact-contract
description: Appliquer le contrat commun de stockage des sorties durables de la crew. Utiliser avant toute création de rapport, plan, audit ou note persistante.
user-invocable: false
---

# Contrat d’artéfacts

Lis [le contrat](../../../docs/crew/ARTIFACT_CONTRACT.md) avant de créer un artéfact durable.

- Identifie le work item actif et son `manifest.yaml`.
- Écris uniquement dans les emplacements autorisés.
- Ajoute le chemin créé, son type et son producteur dans `artifacts` du manifest.
- Référence les ADR et décisions sans les dupliquer.
- Si aucun work item n’existe, appelle d’abord `work-item-manager`.
