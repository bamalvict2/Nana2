#!/bin/bash
echo "🔄 Git + VS Code — Synchronisation"
git remote -v
git pull origin main
code .
git status
