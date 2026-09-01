---
name: toolkit-config
description: Initialiser ou vérifier la configuration SaaS/mobile d’un projet sans y inscrire de secrets. Utiliser avant un travail récurrent d’équipe ou lorsqu’un toolkit manque de contexte.
argument-hint: Indique le type de produit et la stack connue
user-invocable: true
---

# Configuration de toolkit

1. Lis `.crew/toolkit-config.yaml` s’il existe.
2. S’il n’existe pas, propose de le créer depuis le modèle, sans inventer les données inconnues.
3. Renseigne seulement les faits confirmés : stack, plateformes, commandes de validation, environnements et responsables.
4. Laisse `undecided` pour les choix d’architecture non décidés et crée une `[DECISION REQUIRED]` si ces choix bloquent le travail.
5. Ne stocke jamais une clé, token, URL privée, identifiant personnel ou secret dans ce fichier.
