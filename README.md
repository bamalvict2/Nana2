# Nana2

Architecture portable et validée pour Mongo Express API avec cockpit HTML.

## 🔁 Plan de reprise `reprise Bernard api-nanatest`

- Déploiement Mongo Express sur le port 3000
- Source : `.tar` local ou Docker Hub
- Orchestration : Minikube avec 2 replicas
- Environnement : VM Ubuntu (VDC sur laptop W11)
- Validation : cockpit HTML avec tuiles interactives

## 🐳 Docker

```bash
docker load -i mongo-express.tar
docker run -d -p 3000:8081 --name mongo-express mongo-express