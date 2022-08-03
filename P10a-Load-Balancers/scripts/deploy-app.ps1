curl -LO "https://dl.k8s.io/release/v1.24.0/bin/windows/amd64/kubectl.exe"
az cloud set -n AzureUSGovernment
az login
az aks install-cli
az aks get-credentials --resource-group aio-p9-aks --name aks01
./kubectl get nodes
./kubectl apply -f ../apps/vote-app.yaml
./kubectl get service azure-vote-front --watch