#!/bin/bash

LOG="$HOME/cockpit/logs/inspect-installation.log"
mkdir -p "$(dirname "$LOG")"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
echo "🔍 Inspection système à $TIMESTAMP" | tee "$LOG"

# 📦 Paquets APT installés
APT_COUNT=$(dpkg -l | grep '^ii' | wc -l)
echo -e "\n📦 Paquets APT installés : $APT_COUNT" | tee -a "$LOG"
dpkg -l | grep '^ii' | awk '{print $2}' >> "$LOG"

# 📦 Paquets Snap installés
SNAP_COUNT=$(snap list | wc -l)
echo -e "\n📦 Paquets Snap installés : $((SNAP_COUNT - 1))" | tee -a "$LOG"
snap list >> "$LOG"

# 🚫 Snaps désactivés
SNAP_DISABLED=$(snap list --all | awk '/désactivé/{print $1, $2}' | tee -a "$LOG" | wc -l)
echo -e "\n🚫 Snaps désactivés : $SNAP_DISABLED" | tee -a "$LOG"

# 🐳 Conteneurs Docker actifs
DOCKER_COUNT=$(docker ps -q | wc -l)
echo -e "\n🐳 Conteneurs Docker actifs : $DOCKER_COUNT" | tee -a "$LOG"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Image}}" | tee -a "$LOG"

# 🧠 RAM + Swap
echo -e "\n🧠 RAM + Swap :" | tee -a "$LOG"
free -h | tee -a "$LOG"

# 📁 Disque
echo -e "\n📁 Disque :" | tee -a "$LOG"
df -h | tee -a "$LOG"

echo -e "\n✅ Inspection terminée à $(date '+%Y-%m-%d %H:%M:%S')" | tee -a "$LOG"