# Toolkits SaaS et mobile

`saas-toolkit` couvre contrats API, isolation tenant, autorisations, migrations, observabilité et livraison contrôlée.

`mobile-toolkit` couvre navigation, état, réseau, hors-ligne, accessibilité, stockage sécurisé, Android/iOS et préparation de release.

Les deux lisent `.crew/toolkit-config.yaml` lorsqu’il existe. Ce fichier contient uniquement les faits confirmés et les commandes de vérification ; il ne contient jamais de secrets.

Une publication, migration irréversible ou opération de production exige toujours une approbation humaine explicite.
