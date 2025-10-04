#!/bin/bash

echo "🧠 BernardOps — Cycle Git avec validation visuelle"
echo "───────────────────────────────────────────────"

# 🧭 Ouverture cockpit : visualisation complète
echo "🌳 Arbre Git complet — avant toute action"
git log --oneline --graph --decorate --all
echo "───────────────────────────────────────────────"

# Étape 1 : choisir la branche
read -p "🌿 Nom de la branche à utiliser : " branch
echo "📂 Branches disponibles :"
git branch -a
echo "🔀 Branche sélectionnée : $branch"

# Switch si nécessaire
read -p "🔁 Switch vers '$branch' ? (y/n) " step1
current_branch=$(git branch --show-current)
if [[ "$step1" == "y" ]]; then
  if [[ "$current_branch" == "$branch" ]]; then
    echo "✅ Déjà sur '$branch', aucun switch nécessaire"
  elif git show-ref --verify --quiet refs/heads/"$branch"; then
    git switch "$branch"
    echo "🔁 Switched vers '$branch'"
  else
    echo "❌ Branche '$branch' introuvable. Switch annulé."
    exit 1
  fi
  echo "───────────────────────────────────────────────"
fi

# Étape 2 : push vers Nana
read -p "📤 Push vers Nana ? (y/n) " step2
if [[ "$step2" == "y" ]]; then
  echo "📌 Remote actuel :"
  git remote -v
  echo "📜 Dernier commit local :"
  git log -1
  echo "🧪 Diff HEAD vs origin/$branch :"
  git log HEAD..origin/"$branch" --oneline || echo "⚠️ Branche distante introuvable"
  echo "🧼 État Git local :"
  git status
  echo "🧾 Fichiers non suivis :"
  git ls-files --others --exclude-standard
  read -p "✅ Ajouter les fichiers non suivis ? (y/n) " add_files
  if [[ "$add_files" == "y" ]]; then
    git add .
    git commit -m "Ajout des fichiers non suivis"
  fi
  read -p "✅ Confirmer le push vers Nana ? (y/n) " confirm_push
  if [[ "$confirm_push" == "y" ]]; then
    git push origin "$branch"
    echo "✅ Push effectué vers Nana"
    echo "🌳 Visualisation Git après push :"
    git log --oneline --graph --decorate --all
  else
    echo "❌ Push annulé"
  fi
  echo "───────────────────────────────────────────────"
fi

# Étape 3 : pull depuis Nana
read -p "📥 Pull depuis Nana ? (y/n) " step3
if [[ "$step3" == "y" ]]; then
  echo "🧪 Diff HEAD vs origin/$branch :"
  git log HEAD..origin/"$branch" --oneline || echo "⚠️ Branche distante introuvable"
  echo "📜 Dernier commit distant :"
  git log origin/"$branch" -1 || echo "⚠️ Aucun commit distant"
  echo "🧼 État Git local :"
  git status
  read -p "✅ Confirmer le pull depuis Nana ? (y/n) " confirm_pull
  if [[ "$confirm_pull" == "y" ]]; then
    git pull origin "$branch"
    echo "✅ Pull effectué"
  else
    echo "❌ Pull annulé"
  fi
  echo "───────────────────────────────────────────────"
fi

# Étape 4 : supprimer le remote actuel
read -p "🧹 Supprimer le remote origin ? (y/n) " step4
if [[ "$step4" == "y" ]]; then
  git remote remove origin
  echo "❌ Remote origin supprimé"
  echo "───────────────────────────────────────────────"
fi

# Étape 5 : ajouter NanaTest
read -p "🔗 Ajouter le remote NanaTest ? (y/n) " step5
if [[ "$step5" == "y" ]]; then
  git remote add origin https://github.com/bamalvict2/NanaTest.git
  echo "✅ Remote NanaTest ajouté"
  git remote -v
  echo "───────────────────────────────────────────────"
fi

# Étape 6 : push vers NanaTest
read -p "📤 Push vers NanaTest ? (y/n) " step6
if [[ "$step6" == "y" ]]; then
  echo "📜 Dernier commit local :"
  git log -1
  echo "🧪 Diff HEAD vs origin/$branch :"
  git log HEAD..origin/"$branch" --oneline || echo "⚠️ Branche distante introuvable"
  read -p "✅ Confirmer le push vers NanaTest ? (y/n) " confirm_push2
  if [[ "$confirm_push2" == "y" ]]; then
    git push -u origin "$branch"
    echo "✅ Push effectué vers NanaTest"
    echo "🌳 Visualisation Git après push :"
    git log --oneline --graph --decorate --all
  else
    echo "❌ Push annulé"
  fi
  echo "───────────────────────────────────────────────"
fi

# Étape 7 : suppression d'une branche distante
read -p "🗑️ Supprimer une branche distante ? (y/n) " delete_branch
if [[ "$delete_branch" == "y" ]]; then
  read -p "🌿 Nom de la branche à supprimer sur GitHub : " branch_to_delete
  echo "🗑️ Suppression de '$branch_to_delete' sur NanaTest..."
  git push origin --delete "$branch_to_delete"
  echo "✅ Branche '$branch_to_delete' supprimée"
  echo "───────────────────────────────────────────────"
fi

echo "✅ Cycle Git terminé avec BernardOps sur la branche '$branch'"