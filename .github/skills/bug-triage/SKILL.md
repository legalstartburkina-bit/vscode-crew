---
name: bug-triage
description: Reproduire un bug, isoler sa cause, proposer un correctif minimal et démontrer la correction par un test.
user-invocable: true
---

# Triage de bug

1. Reformule le comportement attendu, observé et les étapes de reproduction.
2. Cherche une preuve reproductible avant toute correction.
3. Isole la cause en distinguant symptôme et origine.
4. Propose le correctif minimal et le test qui échoue avant lui ou qui démontre son effet.
5. Après validation utilisateur si le correctif est conséquent, implémente puis passe à `change-review`.
