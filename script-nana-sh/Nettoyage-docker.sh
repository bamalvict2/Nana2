#!/bin/bash
echo "🧹 Étape dock-nettoyage : Nettoyage Docker BernardOps"

# Supprimer les conteneurs arrêtés
echo "🧺 Suppression des conteneurs arrêtés..."
docker container prune -f

# Supprimer les images non utilisées
echo "🖼️ Suppression des images non utilisées..."
docker image prune -f

# Supprimer les volumes inutilisés
echo "📦 Suppression des volumes inutilisés..."
docker volume prune -f

# Supprimer les réseaux inutilisés
echo "🌐 Suppression des réseaux inutilisés..."
docker network prune -f

# Afficher l’espace libéré
echo "📊 Espace disque après nettoyage :"
docker system df

echo "✅ Docker nettoyé avec succès"