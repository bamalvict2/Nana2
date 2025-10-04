#!/bin/bash

LOG="$HOME/cockpit/logs/clean-bernardops.log"
mkdir -p "$(dirname "$LOG")"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
echo "🧹 Nettoyage BernardOps lancé à $TIMESTAMP" | tee "$LOG"

confirm() {
  read -p "👉 Valider cette étape ? (o/N) : " choice
  [[ "$choice" == "o" || "$choice" == "O" ]]
}

# 🧼 APT : nettoyage des paquets obsolètes
echo -e "\n📦 Étape APT : suppression des paquets inutiles" | tee -a "$LOG"
echo "🔎 Cette commande supprime les dépendances installées automatiquement mais devenues inutiles." | tee -a "$LOG"
echo "⚠️ Elle ne touche pas aux paquets essentiels ni à tes outils personnels." | tee -a "$LOG"
if confirm; then
  sudo apt autoremove -y >> "$LOG"
  sudo apt clean >> "$LOG"
  echo "✅ APT nettoyé" | tee -a "$LOG"
else
  echo "⏭️ Étape APT ignorée" | tee -a "$LOG"
fi

# 🔄 Snap : suppression des versions désactivées
echo -e "\n🔄 Étape Snap : suppression des snaps désactivés" | tee -a "$LOG"
echo "🔎 Ubuntu garde les anciennes versions Snap même après mise à jour." | tee -a "$LOG"
echo "⚠️ Cette étape supprime uniquement les versions désactivées, pas les snaps actifs." | tee -a "$LOG"
if confirm; then
  snap list --all | awk '/désactivé/{print $1, $2}' | while read snapname version; do
    echo "🗑️ Suppression de $snapname ($version)" | tee -a "$LOG"
    sudo snap remove "$snapname"
  done
  echo "✅ Snaps désactivés supprimés" | tee -a "$LOG"
else
  echo "⏭️ Étape Snap ignorée" | tee -a "$LOG"
fi

# 🧾 Journaux : purge des logs anciens
echo -e "\n🧾 Étape journaux : purge des logs > 7 jours" | tee -a "$LOG"
echo "🔎 Cette commande libère de l’espace en supprimant les logs système trop anciens." | tee -a "$LOG"
echo "⚠️ Elle ne touche pas aux logs récents ni aux logs cockpit." | tee -a "$LOG"
if confirm; then
  sudo journalctl --vacuum-time=7d >> "$LOG"
  echo "✅ Journaux purgés" | tee -a "$LOG"
else
  echo "⏭️ Étape journaux ignorée" | tee -a "$LOG"
fi

# 🐳 Docker : nettoyage des éléments inutilisés
echo -e "\n🐳 Étape Docker : nettoyage des volumes, images, conteneurs arrêtés" | tee -a "$LOG"
echo "🔎 Cette commande supprime les conteneurs arrêtés, les images non utilisées et les volumes orphelins." | tee -a "$LOG"
echo "⚠️ Elle ne touche pas aux conteneurs actifs comme MongoDB ni aux volumes montés." | tee -a "$LOG"
echo "📋 Conteneurs actifs :" | tee -a "$LOG"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Image}}" | tee -a "$LOG"
echo "📋 Volumes Docker :" | tee -a "$LOG"
docker volume ls | tee -a "$LOG"
if confirm; then
  docker system prune -af --volumes >> "$LOG"
  echo "✅ Docker nettoyé" | tee -a "$LOG"
else
  echo "⏭️ Étape Docker ignorée" | tee -a "$LOG"
fi

# 🗑️ Postman : suppression si présent
echo -e "\n🗑️ Étape Postman : suppression si installé en Snap" | tee -a "$LOG"
echo "🔎 Postman est souvent installé en Snap et peut être lourd si inutilisé." | tee -a "$LOG"
echo "⚠️ Cette étape ne touche rien si Postman est absent." | tee -a "$LOG"
if confirm; then
  if snap list | grep -q postman; then
    sudo snap remove postman >> "$LOG"
    echo "✅ Postman supprimé" | tee -a "$LOG"
  else
    echo "✅ Postman déjà absent" | tee -a "$LOG"
  fi
else
  echo "⏭️ Étape Postman ignorée" | tee -a "$LOG"
fi

# 🧠 Ressources : affichage RAM + disque
echo -e "\n🧠 Étape ressources : affichage RAM + Swap + Disque" | tee -a "$LOG"
echo "🔎 Cette étape te permet de visualiser l’état mémoire et disque après nettoyage." | tee -a "$LOG"
if confirm; then
  free -h | tee -a "$LOG"
  df -h | tee -a "$LOG"
  echo "✅ Ressources affichées" | tee -a "$LOG"
else
  echo "⏭️ Étape ressources ignorée" | tee -a "$LOG"
fi

echo -e "\n✅ Nettoyage BernardOps terminé à $(date '+%Y-%m-%d %H:%M:%S')" | tee -a "$LOG"