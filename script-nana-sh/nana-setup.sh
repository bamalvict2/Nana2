#!/bin/bash

echo "🧠 BernardOps — Préparation de l’environnement Nana Chicago"

# Créer les scripts nana1 à nana9 s’ils n’existent pas
echo "📁 Vérification des scripts nana1.sh à nana9.sh..."
touch nana{11..19}.sh

# Créer git-sync-vsc.sh s’il n’existe pas
echo "📁 Vérification de git-sync-vsc.sh..."
touch git-sync-vsc.sh

# Rendre tous les scripts exécutables
echo "🔐 Attribution des droits d’exécution..."
chmod +x nana{1..9}.sh git-sync-vsc.sh

# Vérifier les chemins critiques
echo "📂 Vérification du dossier api-mongo..."
ls ~/Nana/api-mongo || echo "⚠️ Dossier ~/Nana/api-mongo introuvable"

echo "📂 Vérification du dossier k8s..."
ls ~/Nana/api-mongo/k8s || echo "⚠️ Dossier ~/Nana/api-mongo/k8s introuvable"

# Afficher les scripts disponibles
echo "📜 Scripts disponibles dans ~/Nana/script-nana-sh :"
ls -1 ~/Nana/script-nana-sh | grep '.sh'

echo "✅ Environnement prêt pour redeploiement BernardOps"
