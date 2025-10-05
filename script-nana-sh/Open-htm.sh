#!/bin/bash

read -p "Nom du fichier HTML (dans ~/Templates) : " FILENAME
FILE="/home/bamalvict/Templates/$FILENAME"

if [ ! -f "$FILE" ]; then
  echo "❌ Fichier introuvable : $FILE"
  exit 1
fi

echo "✅ Ouverture de $FILENAME à $(date '+%Y-%m-%d %H:%M:%S')"
firefox "file://$FILE"