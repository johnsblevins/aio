param deploymentid string = substring(uniqueString(utcNow()),0,6)
param elbDeployments array
param ilbDeployments array
param adminUsername string
@secure()
param adminPassword string
param location string 

targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'aio-p10a-load-balancers'
  location: location
}

module deploy_elb '../../bicep-core/elb.bicep' = [for elbDeployment in elbDeployments: {
  name: 'Def-${elbDeployment.elbName}-${deploymentid}'
  scope: rg
  params: {
    adminUsername: adminUsername
    dnsNameforLBIP: elbDeployment.dnsNameforLBIP
    adminPassword: adminPassword
    location: location
  }
}]

module deploy_ilb '../../bicep-core/ilb.bicep' = [for ilbDeployment in ilbDeployments: {
  name: 'Def-${ilbDeployment.ilbName}-${deploymentid}'
  scope: rg
  params: {    
    adminUsername: adminUsername
    adminPassword: adminPassword
    location: location
  }
  dependsOn: [
    deploy_elb
  ]
}]
