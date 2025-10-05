# 🐳 Active l'environnement Docker de Minikube
docker-env:
	eval $$(minikube docker-env)

# 🚀 Démarre Minikube
start:
	minikube start

# 🔄 Reset complet du cluster Minikube
reset:
	minikube stop && minikube delete && minikube start

# 📦 Build l'image localement (si tu n'utilises pas DockerHub)
build:
	docker build -t nana-api:latest .

# 📄 Déploie les fichiers YAML
deploy:
	kubectl apply -f k8s/nana-api-deployment.yaml
	kubectl apply -f k8s/nana-api-service.yaml

# 🔍 Vérifie que les fichiers YAML sont valides
validate-yaml:
	kubectl apply --dry-run=client -f k8s/nana-api-deployment.yaml
	kubectl apply --dry-run=client -f k8s/nana-api-service.yaml

# 🔁 Redémarre uniquement le pod nana-api
restart:
	kubectl delete pod -l app=nana-api
	kubectl apply -f k8s/nana-api-deployment.yaml

# 🌐 Expose l'API Nana en local
port:
	kubectl port-forward svc/nana-api 3000:3000

# 🧪 Teste l'endpoint principal
test-api:
	curl http://localhost:3000/api/test

# 🧹 Supprime tous les objets liés à Nana API
clean-all:
	kubectl delete -f k8s/

# 📊 Affiche l'état des pods et services
status:
	kubectl get pods
	kubectl get svc

# 📁 Affiche les logs du pod nana-api
logs:
	kubectl logs deployment/nana-api

# 🧭 Rejoue tout le cockpit en une commande
replay-chicago: start docker-env build validate-yaml deploy port test-api