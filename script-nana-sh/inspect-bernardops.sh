#!/bin/bash

LOG="$HOME/cockpit/logs/inspect-bernardops.log"
mkdir -p "$(dirname "$LOG")"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
echo "🔍 Inspection BernardOps à $TIMESTAMP" | tee "$LOG"

echo -e "\n📦 Paquets APT installés :" | tee -a "$LOG"
dpkg -l | grep '^ii' | awk '{print $2}' | tee -a "$LOG"

echo -e "\n📦 Snaps installés :" | tee -a "$LOG"
snap list | tee -a "$LOG"

echo -e "\n🐳 Conteneurs Docker actifs :" | tee -a "$LOG"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Image}}" | tee -a "$LOG"

echo -e "\n🧠 RAM + Swap :" | tee -a "$LOG"
free -h | tee -a "$LOG"

echo -e "\n📁 Disque :" | tee -a "$LOG"
df -h | tee -a "$LOG"

echo "✅ Inspection terminée à $(date '+%Y-%m-%d %H:%M:%S')" | tee -a "$LOG"