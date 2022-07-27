param deploymentid string = substring(uniqueString(utcNow()),0,6)
param aksDeployments array
param sshRSAPublicKey string
param location string 

targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'aio-p9-aks'
  location: location
}

module deploy_aks '../../bicep-core/aks.bicep' = [for aksDeployment in aksDeployments: {
  name: 'Def-${aksDeployment.clusterName}-${deploymentid}'
  scope: rg
  params: {
    linuxAdminUsername: aksDeployment.linuxAdminUsername
    sshRSAPublicKey: sshRSAPublicKey
    dnsPrefix: aksDeployment.dnsPrefix
    agentCount: aksDeployment.agentCount
    agentVMSize: aksDeployment.agentVMSize
    clusterName: aksDeployment.clusterName
    location: aksDeployment.location
  }
}]
