#!/bin/bash

echo "🧠 BernardOps — Création d'une branche Git avec commit initial"

# Demander le nom de la branche
read -p "🌿 Nom de la nouvelle branche à créer : " branch

# Demander le message de commit
read -p "📝 Message du premier commit : " commit_msg

# Étape 1 : Créer la branche
read -p "🔀 Créer la branche '$branch' ? (y/n) " confirm_branch
if [[ "$confirm_branch" == "y" ]]; then
  git checkout -b "$branch"
fi

# Étape 2 : Ajouter tous les fichiers
read -p "📦 Ajouter tous les fichiers ? (y/n) " confirm_add
if [[ "$confirm_add" == "y" ]]; then
  git add .
fi

# Étape 3 : Faire le commit
read -p "📝 Faire le commit avec message '$commit_msg' ? (y/n) " confirm_commit
if [[ "$confirm_commit" == "y" ]]; then
  git commit -m "$commit_msg"
fi

# Étape 4 : Pousser vers le dépôt distant
read -p "📤 Pousser la branche '$branch' vers GitHub ? (y/n) " confirm_push
if [[ "$confirm_push" == "y" ]]; then
  git push -u origin "$branch"
fi

# Étape vue : visualisation générale
read -p "🔍 Voir le log Git ? (y/n) " vue
if [[ "$vue" == "y" ]]; then
  git log --pretty=oneline
fi
echo "✅ Branche '$branch' créée et commitée avec BernardOps"



