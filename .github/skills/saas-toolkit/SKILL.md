---
name: saas-toolkit
description: Piloter une fonctionnalité SaaS de manière sûre : contrat API, isolation client, autorisations, données, observabilité et livraison contrôlée.
argument-hint: Décris la fonctionnalité SaaS ou le changement backend
user-invocable: true
---

# Toolkit SaaS

Lis `.crew/toolkit-config.yaml`, les ADR, le work item et le brief quand ils existent. Si le produit est hybride, coordonne le contrat avec `mobile-toolkit`.

1. Charge `saas-api-contracts` pour toute création ou modification d’API, événement, webhook ou modèle de données exposé.
2. Charge `saas-multitenancy` lorsqu’une donnée peut appartenir à un client, une organisation ou une équipe.
3. Charge `security-review` avant une modification d’authentification, de rôle, paiement, données personnelles ou opération de production.
4. Charge `database-migration` pour toute évolution de schéma.
5. Charge `saas-release-readiness` avant de déclarer le travail livrable.

Ne suppose jamais le modèle de tenancy, le fournisseur d’identité ou le comportement de production : un choix manquant devient `[DECISION REQUIRED]`.
