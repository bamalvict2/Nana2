#!/bin/bash
echo "📤 BernardOps — Push Git sécurisé"
git branch -a
read -p "🌿 Branche à pousser : " branch
git status
git log -1
git log HEAD..origin/"$branch" --oneline
git remote -v
read -p "✅ Ajouter les fichiers non suivis ? (y/n) " add
if [[ "$add" == "y" ]]; then
  git add .
  git commit -m "Ajout des fichiers non suivis"
fi
read -p "✅ Confirmer le push ? (y/n) " confirm
if [[ "$confirm" == "y" ]]; then
  git push origin "$branch"
  echo "🌳 Arbre Git après push :"
  git log --oneline --graph --decorate --all
else
  echo "❌ Push annulé"
fi