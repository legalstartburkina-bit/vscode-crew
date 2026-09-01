---
name: mobile-toolkit
description: Piloter une fonctionnalité mobile React Native, Flutter ou native avec navigation, réseau, stockage, qualité plateforme et release contrôlée.
argument-hint: Décris la fonctionnalité mobile ou l’écran à construire
user-invocable: true
---

# Toolkit mobile

Lis `.crew/toolkit-config.yaml`, les ADR, le work item et le brief lorsqu’ils existent. Si l’application dépend d’un SaaS, aligne d’abord le contrat avec `saas-api-contracts`.

1. Charge `mobile-development` pour les écrans, navigation, état, données et intégration API.
2. Charge `mobile-quality` pour les parcours UI, accessibilité, réseau dégradé, hors-ligne et plateformes ciblées.
3. Charge `security-review` pour token, permission, deep link, stockage local, données personnelles ou paiement.
4. Charge `mobile-release-readiness` avant toute déclaration de livraison.

Ne suppose jamais la stratégie hors-ligne, les plateformes visées, les versions minimales ou le stockage sécurisé : toute information manquante importante devient `[DECISION REQUIRED]`.
