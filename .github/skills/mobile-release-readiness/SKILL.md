---
name: mobile-release-readiness
description: Préparer une livraison mobile Android/iOS : version, build, signature, configuration, conformité et retour arrière sans publier automatiquement.
user-invocable: true
---

# Préparation de release mobile

1. Vérifie la version, les notes de version, environnements, identifiants d’application et configuration de build sans exposer de secrets.
2. Exécute les builds Android/iOS configurés lorsqu’ils sont disponibles ; sinon indique précisément le blocage.
3. Vérifie permissions, deep links, crash reporting, politique de confidentialité et stratégie de retour arrière.
4. Consigne les résultats dans le manifest du work item.
5. Retourne un verdict prêt pour approbation, bloqué ou décision requise. Ne publie jamais sur un store sans approbation humaine explicite.
