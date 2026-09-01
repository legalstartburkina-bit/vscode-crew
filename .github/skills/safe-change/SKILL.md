---
name: safe-change
description: Évaluer les opérations risquées avant une modification de dépendances, données, infrastructure ou sécurité.
---

# Changement sûr

Avant de modifier une dépendance, une migration, l'authentification, les permissions ou une infrastructure :

- décris l'impact et le mécanisme de retour arrière ;
- identifie les secrets et données à ne jamais afficher ;
- demande confirmation avant une suppression, un déploiement, une migration irréversible ou un push forcé ;
- privilégie une vérification non destructive.
