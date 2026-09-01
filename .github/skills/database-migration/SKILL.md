---
name: database-migration
description: Préparer et vérifier une évolution de schéma ou migration de données avec retour arrière, validation et sécurité.
user-invocable: true
---

# Migration de base de données

1. Décris le schéma actuel, le schéma cible, les données affectées et les consommateurs du contrat.
2. Définis la stratégie de compatibilité, sauvegarde et retour arrière.
3. Marque les destructions, pertes de données et indisponibilités `[DECISION REQUIRED]`.
4. Prépare les validations avant et après migration, sans l’exécuter sans confirmation explicite.
5. Passe à `security-review`, puis `change-review`.
