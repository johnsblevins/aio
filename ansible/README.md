# Instructions

1. Create D-Series Windows 10 VM with Public IP

2. Install WSL2 - https://docs.microsoft.com/en-us/windows/wsl/install
```
(elevated PowerShell)
wsl --install
shutdown -r -t 0
(login to complete configuration)
```
3. Install VSCode - https://code.visualstudio.com/Download

4. Install VSCode Extensions

    * Remote - WSL - https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl
    * Bicep - https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/install#vs-code-and-bicep-extension
    * Ansible

5. Install AZ Cli

```
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
az cloud set -n AzureUSGovernment
az login
az account list -o table
az account set -s <sub name or id>
az account show -o table
```
6. Install Ansible
```
sudo apt install ansible
```

7. Clone Repo - https://github.com/johnsblevins/aio

8. Deploy VM with Bicep

```
./deploy-bicep.sh
```

9. Configure VM with Ansible

```
./deploy-ansible.sh
```
