#!/bin/bash
echo "🧠 BernardOps — Nouvelle branche + commit propre"
echo "───────────────────────────────────────────────"

# 🔗 Choix du dépôt distant
echo "🔗 Choisir le dépôt distant :"
echo "1) Nana"
echo "2) NanaTest"
read -p "👉 Choix (1 ou 2) : " choix_remote

if [[ "$choix_remote" == "1" ]]; then
  remote_url="https://github.com/bamalvict2/Nana2.git"
  remote_name="Nana"
elif [[ "$choix_remote" == "2" ]]; then
  remote_url="https://github.com/bamalvict2/NanaTest.git"
  remote_name="NanaTest"
else
  echo "❌ Choix invalide. Script annulé."
  exit 1
fi

# 🔄 Réinitialiser le remote origin
git remote remove origin 2>/dev/null
git remote add origin "$remote_url"
echo "✅ Remote '$remote_name' configuré : $remote_url"
echo "───────────────────────────────────────────────"

# 🌳 Visualisation Git avant toute action
echo "🌳 Arbre Git complet"
git log --pretty=oneline --graph --decorate --all
echo "───────────────────────────────────────────────"

# 🧼 Vérifier HEAD
echo "🧼 État Git local"
git status

# 🆕 Créer une nouvelle branche
read -p "🌿 Nom de la nouvelle branche : " new_branch
git checkout -b "$new_branch"
echo "✅ Branche '$new_branch' créée et activée"
echo "───────────────────────────────────────────────"

# 🧾 Ajouter les fichiers non suivis
echo "🧾 Fichiers non suivis :"
git ls-files --others --exclude-standard
read -p "✅ Ajouter tous les fichiers non suivis ? (y/n) " add_files
if [[ "$add_files" == "y" ]]; then
  git add .
  read -p "📝 Message du commit : " commit_msg
  git commit -m "$commit_msg"
  echo "✅ Commit effectué sur '$new_branch'"
  echo "───────────────────────────────────────────────"
fi

# 🌳 Visualisation après commit
echo