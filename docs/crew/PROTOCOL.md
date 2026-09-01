# Protocole de décision

Autorité : décision explicite utilisateur → ADR accepté → contrat ou invariant → spécification → plan → code → recommandation d’agent → hypothèse du modèle.

États : `INTENT_CAPTURED` → `CONTEXT_READY` → `ANALYSIS_READY` → `ARBITRATION_PENDING` → `IMPLEMENTATION_READY` → `EXECUTING` → `REVIEW_PENDING` → `VERIFIED`.

Pendant `ARBITRATION_PENDING`, aucun changement d’implémentation n’est autorisé. Builder travaille uniquement à partir d’un brief validé ; Reviewer compare les changements aux décisions et au brief.
