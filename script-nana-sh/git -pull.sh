#!/bin/bash
echo "📥 BernardOps — Pull Git validé"
git branch -a
read -p "🌿 Branche à tirer : " branch
git log HEAD..origin/"$branch" --oneline
git log origin/"$branch" -1
git status
read -p "✅ Confirmer le pull ? (y/n) " confirm
if [[ "$confirm" == "y" ]]; then
  git pull origin "$branch"
else
  echo "❌ Pull annulé"
fi