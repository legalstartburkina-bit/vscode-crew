---
name: saas-release-readiness
description: Vérifier qu’un changement SaaS est prêt pour une livraison contrôlée : validations, migrations, observabilité, rollback et approbation humaine.
user-invocable: true
---

# Préparation de livraison SaaS

1. Lis les commandes de validation configurées et les résultats réellement exécutés.
2. Vérifie migrations, compatibilité API, variables de configuration, métriques, alertes et stratégie de retour arrière.
3. Consigne les validations dans le manifest du work item.
4. Retourne un verdict : prêt pour approbation, bloqué ou décision requise.
5. Ne déploie pas et ne lance aucune migration de production : une approbation humaine explicite est obligatoire.
