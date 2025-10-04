#!/bin/bash

# 📁 Préparation du log
mkdir -p "$HOME/cockpit/logs"
LOG="$HOME/cockpit/logs/clean-bernardops.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "🧹 Nettoyage BernardOps lancé à $TIMESTAMP" | tee "$LOG"

# 📦 Étape 1 : Suppression des paquets obsolètes
echo -e "\n📦 Suppression des paquets obsolètes..." | tee -a "$LOG"
sudo apt autoremove -y | tee -a "$LOG"

# 🧹 Étape 2 : Nettoyage du cache APT
echo -e "\n🧹 Nettoyage du cache APT..." | tee -a "$LOG"
sudo apt clean | tee -a "$LOG"

# 🧠 Étape 3 : Vérification de la mémoire
echo -e "\n🧠 État de la mémoire (RAM + Swap) :" | tee -a "$LOG"
free -h | tee -a "$LOG"

# 📁 Étape 4 : Vérification du disque
echo -e "\n📁 État du disque :" | tee -a "$LOG"
df -h | tee -a "$LOG"

# ✅ Étape 5 : Journalisation finale
ENDTIME=$(date '+%Y-%m-%d %H:%M:%S')
echo -e "\n✅ Nettoyage terminé à $ENDTIME" | tee -a "$LOG"
echo "✅ Système nettoyé" | tee -a "$LOG"