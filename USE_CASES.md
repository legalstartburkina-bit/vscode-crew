# Exemples d’utilisation — VS Code DeepSeek Crew

Chaque exemple commence dans le chat VS Code avec le modèle DeepSeek sélectionné et l’agent **Captain**.

## 1. Comprendre un dépôt avant de coder

**Objectif :** prendre en main un projet inconnu sans modifier son code.

Prompt à Captain :

```text
Analyse ce dépôt. Explique son architecture, le point d’entrée, les commandes de test et les trois risques techniques principaux. Ne modifie aucun fichier.
```

Déroulé attendu :

1. Captain délègue l’exploration à Architect.
2. Architect lit le code et retourne une cartographie du projet avec les commandes observées.
3. Captain consolide les résultats et indique les zones à clarifier.

**Résultat :** une synthèse fondée sur le code réel, sans changement dans le dépôt.

## 2. Ajouter une fonctionnalité

**Objectif :** ajouter une page de profil dans une application web.

Prompt à Captain :

```text
Nous voulons ajouter une page Profil où l’utilisateur peut voir et modifier son nom et son avatar. Commence par un plan. Ne code rien avant que je valide le plan.
```

Après validation du plan :

```text
Le plan est validé. Passe à Builder pour l’implémenter, puis demande une revue complète à Reviewer.
```

**Résultat :** Architect définit les fichiers, API et tests ; Builder réalise les modifications ; Reviewer vérifie les régressions avant livraison.

## 3. Corriger un bug reproductible

**Objectif :** corriger un échec de connexion après expiration de session.

Prompt à Captain :

```text
Quand une session expire, l’utilisateur voit une erreur 500 au lieu d’être redirigé vers la connexion. Reproduis et localise la cause. Propose un correctif minimal et le test qui le démontre.
```

Après validation :

```text
Applique le correctif minimal validé. Lance le test concerné et indique précisément son résultat.
```

**Résultat :** le problème est traité comme une hypothèse à vérifier, puis la correction est accompagnée d’une preuve de test.

## 4. Revue de code avant une pull request

**Objectif :** contrôler les changements avant de les partager.

Prompt à Reviewer :

```text
Relis les changements non commités du dépôt. Cherche les régressions, les cas limites, les problèmes de lisibilité et les tests manquants. Classe les remarques par gravité et ne modifie rien.
```

**Résultat :** une revue structurée : problème, fichier concerné, impact et action recommandée. S’il n’y a pas de problème bloquant, Reviewer l’indique avec les limites de son analyse.

## 5. Vérifier un changement sensible

**Objectif :** évaluer une modification qui touche l’authentification ou des données personnelles.

Prompt à Security :

```text
Évalue la sécurité de cette modification d’authentification avant son implémentation. Cherche les risques liés aux tokens, aux autorisations, aux erreurs exposées et aux journaux. Ne modifie rien.
```

**Résultat :** Security fournit, pour chaque risque, son impact, sa probabilité, la preuve dans le code et une correction conseillée. Les opérations irréversibles restent soumises à ta confirmation.

## 6. Refactoriser sans changer le comportement

**Objectif :** réduire la duplication dans un module.

Prompt à Captain :

```text
Analyse la duplication dans le dossier src/services. Propose un refactor qui ne change pas le comportement public et qui reste limité à ce dossier. Attends ma validation avant toute modification.
```

Après validation :

```text
Implémente uniquement le refactor approuvé. Exécute les tests du module, puis fais vérifier le diff par Reviewer.
```

**Résultat :** le périmètre est contrôlé et les tests servent de filet de sécurité.

## Réflexe utile

Pour tout travail dépassant une petite modification :

```text
Captain, commence par analyser et planifier. Attends ma validation avant de demander à Builder de modifier les fichiers. Termine par une revue et donne-moi les vérifications exécutées.
```

Cela donne à la crew un cadre clair : réfléchir, valider, construire, vérifier.
