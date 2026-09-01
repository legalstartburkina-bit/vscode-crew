# VS Code DeepSeek Crew

Une crew légère, utilisable dans VS Code avec les agents personnalisés et un modèle BYOK, notamment DeepSeek.

## Composition

| Agent | Mission |
| --- | --- |
| Captain | Cadre la demande, délègue et consolide le résultat. |
| Architect | Analyse le dépôt et produit un plan sans modifier le code. |
| Builder | Implémente un plan validé et exécute les vérifications. |
| Reviewer | Relit les changements et repère les régressions. |
| Security | Audite les risques et conseille les garde-fous. |

## Installation dans un projet VS Code

Depuis PowerShell, exécute :

```powershell
.\install.ps1 -Workspace "C:\chemin\vers\ton-projet"
```

Le script copie seulement les personnalisations de la crew dans le projet cible. Il refuse d'écraser une personnalisation existante sans l'option `-Force`.

Pour initialiser le protocole de projet (ADR, spécifications et contexte durable) en même temps :

```powershell
.\install.ps1 -Workspace "C:\chemin\vers\ton-projet" -InitializeProtocol
```

Dans VS Code, ouvre ensuite **Chat: Open Customizations**. Les cinq agents apparaissent dans la liste.

## Connecter DeepSeek

1. Dans VS Code, lance **Chat: Manage Language Models**.
2. Choisis **Add Models**, puis **Custom Endpoint**.
3. Utilise `deepseek.chatLanguageModels.example.json` comme modèle de configuration.
4. Saisis la clé API seulement dans la demande sécurisée de VS Code ; ne la mets jamais dans un fichier ou dans Git.
5. Dans le chat, choisis le modèle DeepSeek, puis l'agent souhaité.

Pour les sessions de la fenêtre **Agents**, active si nécessaire `chat.agentHost.byokModels.enabled` dans les paramètres VS Code. Cette fonction est actuellement expérimentale.

## Utilisation recommandée

Commence avec Captain : « Analyse ce dépôt et propose un plan pour … ». Valide le plan, passe à Builder, puis termine par Reviewer. Security est conseillé avant une migration, un déploiement, une modification d'authentification ou une opération sur des données.

## Sécurité

Le hook PowerShell bloque des commandes clairement dangereuses avant leur exécution. Il complète, mais ne remplace pas, ta validation humaine : lis toujours les commandes proposées, ne commite aucune clé API et évite `-Force` tant que tu n'as pas vérifié la cible.

## Protocole de décision

La crew applique l'ordre d'autorité suivant : décision explicite de l'utilisateur, ADR accepté, contrat ou invariant, spécification, plan, code, recommandation d'agent, hypothèse du modèle. Une recommandation ou du code existant ne remplace jamais silencieusement une décision acceptée.

Pour tout changement important, Captain suit les états : `INTENT_CAPTURED` → `CONTEXT_READY` → `ANALYSIS_READY` → `ARBITRATION_PENDING` (si une décision est nécessaire) → `IMPLEMENTATION_READY` → `EXECUTING` → `REVIEW_PENDING` → `VERIFIED`.

Tant qu'une décision importante est en attente, Builder ne modifie aucun fichier. Les modèles créés par `-InitializeProtocol` sont décrits dans [PROTOCOL.md](PROTOCOL.md).

## Boîte à outils de skills

Le [catalogue de skills](SKILL_CATALOG.md) indique quel skill utiliser et dans quel ordre. Ils sont disponibles dans le projet via `.github/skills/`. Pour installer un skill dans ta boîte à outils personnelle, disponible dans tous tes projets VS Code :

```powershell
.\install-skill.ps1 -SkillPath ".\.github\skills\bug-triage" -Scope Personal
```

Pour l’installer dans un projet précis :

```powershell
.\install-skill.ps1 -SkillPath ".\.github\skills\bug-triage" -Scope Workspace -Workspace "C:\chemin\vers\ton-projet"
```

Dans le chat VS Code, utilise `/skill-router` pour demander à Captain de choisir la chaîne appropriée.

## Données et livrables de la crew

Chaque travail non trivial possède un dossier unique dans `docs/work-items/<id>/` et un `manifest.yaml`. Les rapports, audits et revues sont enregistrés dans ce dossier, puis référencés dans le manifest ; les ADR, spécifications et état de projet gardent leurs emplacements dédiés. Le détail des règles est dans [ARTIFACT_CONTRACT.md](ARTIFACT_CONTRACT.md).

Le hook bloque aussi les rapports de pilotage créés hors de ces emplacements. Il laisse le code applicatif et les fichiers standards comme `README.md` inchangés.

## Toolkits SaaS et mobile

La crew inclut des toolkits pour les équipes qui développent un SaaS, une application mobile ou les deux. Lis [TOOLKITS.md](TOOLKITS.md) pour les chaînes et critères de livraison. Après l’initialisation du protocole, configure progressivement `.crew/toolkit-config.yaml` : la stack, les commandes de validation et les règles confirmées, jamais les secrets.
