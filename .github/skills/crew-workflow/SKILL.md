---
name: crew-workflow
description: Orchestrer un changement de façon traçable : cadrage, plan, implémentation, vérification et revue.
---

# Workflow de la crew

1. Lis `.crew/context.md`, `.crew/project-state.md`, les ADR acceptés et la spécification applicable lorsqu’ils existent.
2. Reformule l'objectif et explicite les critères d'acceptation.
3. Pour un changement non trivial, demande un plan à Architect avant toute édition.
4. Si une question touche l’architecture, la sécurité, les données, un contrat ou un coût, marque-la `[DECISION REQUIRED]` et attends une décision explicite.
5. Builder réalise uniquement un brief d’implémentation validé, en gardant les changements limités au besoin.
6. Exécute le test, lint ou build le plus pertinent. Si aucun contrôle n'est disponible, indique-le.
7. Reviewer examine le diff par rapport au brief et aux ADR avant de déclarer le travail terminé.

Ne déclare jamais une tâche terminée sans citer la vérification effectuée ou l'absence justifiée de vérification.
