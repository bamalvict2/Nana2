#!/bin/bash

LOG="$HOME/cockpit/logs/clean-bernardops.log"
mkdir -p "$(dirname "$LOG")"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
echo "🧹 Nettoyage BernardOps lancé à $TIMESTAMP" | tee -a "$LOG"

# Fonctions modulaires
clean_apt() {
  echo "📦 Suppression des paquets obsolètes..." | tee -a "$LOG"
  sudo apt autoremove -y >> "$LOG"
  sudo apt clean >> "$LOG"
}

clean_snap() {
  echo "🔄 Suppression des snaps désactivés..." | tee -a "$LOG"
  snap list --all | awk '/désactivé/{print $1, $2}' | while read snapname version; do
    echo "🗑️ Suppression de $snapname ($version)" | tee -a "$LOG"
    sudo snap remove "$snapname"
  done
}

clean_journaux() {
  echo "🧾 Purge des journaux > 7 jours..." | tee -a "$LOG"
  sudo journalctl --vacuum-time=7d >> "$LOG"
}

clean_postman() {
  if snap list | grep -q postman; then
    echo "🗑️ Suppression de Postman..." | tee -a "$LOG"
    sudo snap remove postman >> "$LOG"
  else
    echo "✅ Postman déjà absent." | tee -a "$LOG"
  fi
}

clean_docker() {
  echo "🐳 Nettoyage Docker (volumes, images, conteneurs arrêtés)..." | tee -a "$LOG"
  docker system prune -af --volumes >> "$LOG"
}

check_resources() {
  echo "🧠 Mémoire RAM + Swap :" | tee -a "$LOG"
  free -h | tee -a "$LOG"
  echo "📁 Disque :" | tee -a "$LOG"
  df -h | tee -a "$LOG"

  DISK_USED=$(df / | awk 'NR==2 {print $5}' | tr -d '%')
  if [ "$DISK_USED" -ge 90 ]; then
    echo "⚠️ Attention : disque utilisé à $DISK_USED%" | tee -a "$LOG"
    notify-send "⚠️ BernardOps" "Disque presque plein : $DISK_USED%"
  fi
}

# Menu interactif (facultatif)
if [[ "$1" == "--menu" ]]; then
  CHOICES=$(whiptail --title "🧹 BernardOps - Nettoyage modulaire" \
    --checklist "Sélectionne les modules à exécuter :" 20 60 10 \
    "APT" "Nettoyage des paquets" ON \
    "Snap" "Suppression des snaps désactivés" OFF \
    "Journaux" "Purge des logs > 7 jours" OFF \
    "Postman" "Suppression de Postman" OFF \
    "Docker" "Nettoyage Docker" OFF \
    "Ressources" "Afficher RAM + Disque" ON \
    3>&1 1>&2 2>&3)

  [[ $? -ne 0 ]] && echo "❌ Nettoyage annulé." && exit 1

  [[ $CHOICES == *"APT"* ]] && clean_apt
  [[ $CHOICES == *"Snap"* ]] && clean_snap
  [[ $CHOICES == *"Journaux"* ]] && clean_journaux
  [[ $CHOICES == *"Postman"* ]] && clean_postman
  [[ $CHOICES == *"Docker"* ]] && clean_docker
  [[ $CHOICES == *"Ressources"* ]] && check_resources
else
  # Dispatch des options en ligne de commande
  for arg in "$@"; do
    case $arg in
      --apt) clean_apt ;;
      --snap) clean_snap ;;
      --journaux) clean_journaux ;;
      --postman) clean_postman ;;
      --docker) clean_docker ;;
      --ressources) check_resources ;;
      *) echo "❌ Option inconnue : $arg" ;;
    esac
  done
fi

echo "✅ Nettoyage terminé à $(date '+%Y-%m-%d %H:%M:%S')" | tee -a "$LOG"