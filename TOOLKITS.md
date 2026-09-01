# Toolkits startup : SaaS et mobile

Les toolkits transforment les règles générales de la crew en procédures adaptées au produit. Ils sont utilisables sans configuration : l’agent examine le dépôt et demande les informations manquantes. Pour un travail régulier d’équipe, renseigne `.crew/toolkit-config.yaml` à partir du modèle.

## Choisir le toolkit

| Indice dans le dépôt ou la demande | Toolkit |
| --- | --- |
| API, dashboard, comptes, rôles, paiements, multi-tenant | `saas-toolkit` |
| React Native, Flutter, Android, iOS, écran mobile, store | `mobile-toolkit` |
| Produit mixte | Les deux : SaaS pour le contrat et backend, mobile pour le client. |

## Ce que chaque toolkit impose

| Sujet | SaaS | Mobile |
| --- | --- | --- |
| Architecture | Contrats API, isolation tenant, autorisations, migrations. | Navigation, état, réseau, compatibilité plateforme. |
| Sécurité | Secrets, RBAC, données clients, audit, rate limiting. | Stockage sécurisé, permissions, deep links, données locales. |
| Qualité | Tests API, intégration, observabilité, retour arrière. | Tests UI, hors-ligne, taille d’écran, build Android/iOS. |
| Livraison | Environnement, migrations, métriques et rollback. | Version, builds signés, conformité store et rollback. |

## Définition de terminé pour une équipe

Une fonctionnalité n’est prête que si :

- le work item et son manifest sont à jour ;
- les ADR et décisions applicables sont respectés ;
- les critères d’acceptation ont une preuve de validation ;
- les risques SaaS ou mobile pertinents ont été revus ;
- Reviewer a donné un verdict ;
- toute publication, migration irréversible ou manipulation de production a reçu une approbation humaine explicite.

## Utilisation

```text
/skill-router Ajouter la facturation par abonnement dans notre SaaS.
/skill-router Créer un écran mobile de connexion qui fonctionne hors ligne.
```

Captain choisit et annonce le toolkit et la chaîne. Il ne suppose jamais le fournisseur de paiement, le modèle de tenancy, la stratégie de stockage des tokens ou la cible de publication : ce sont des décisions documentées quand elles sont importantes.
