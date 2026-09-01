---
name: saas-multitenancy
description: Vérifier l’isolation des données et des actions entre organisations, comptes ou tenants dans un SaaS.
user-invocable: true
---

# Isolation SaaS

1. Identifie la frontière de tenant et le modèle configuré ou décidé.
2. Trace chaque chemin d’accès à la donnée : requête, cache, tâche asynchrone, export et log.
3. Vérifie que l’autorisation est appliquée côté serveur, pas seulement dans l’interface.
4. Ajoute des tests négatifs inter-tenant lorsque le code ou les tests sont modifiés.
5. Si le modèle d’isolation est `undecided`, bloque l’implémentation sensible avec `[DECISION REQUIRED]`.
