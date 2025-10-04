
  
# ▶️ Lancer lancer un SH  -tous -ou un répertoire
   
  
1. 	 Créer et Sauvegarde le script :nano deploy-nana.sh

2. 	Rends-le exécutable :chmod +x deploy-nana.sh

3. 	Exécute-le :./deploy-nana.sh


4)Rends tous les .sh ecécutable le script :
chmod +x *.sh


5)Rends les .sh ecécutable de 1... à 9 :
chmod +x nana{1..9}.sh git-sync-v.sh
  
---------------------------------------------------------------------

sh deploy Chicago à exécuter en terminal ubuntu

#!/bin/bash

echo "🚀 DÉPLOIEMENT NANA — MÉTHODE CHICAGO"

echo "🔧 Contexte Docker Minikube"
eval $(minikube docker-env)

echo "📦 Build image locale"
docker build -t nana-api:latest .

echo "📋 Tag & push vers DockerHub"
docker tag nana-api:latest bernardchicago/nana-api:latest
docker push bernardchicago/nana-api:latest

echo "⚙️ Apply YAML Kubernetes"
kubectl apply -f k8s/nana-api-deployment.yaml
kubectl apply -f k8s/nana-api-service.yaml

echo "⏳ Attente des pods Running..."
kubectl wait --for=condition=ready pod -l app=nana-api --timeout=60s

echo "🧪 Port-forward local"
kubectl port-forward svc/nana-api 3000:3000 &
sleep 2

echo "📋 Test backend"
curl -s http://localhost:3000 || echo "❌ Backend ne répond pas"

echo "🔍 Logs backend"
kubectl logs deployment/nana-api | tail -n 10

echo "✅ Déploiement terminé — Nana est en ligne"
