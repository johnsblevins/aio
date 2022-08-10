param deploymentid string = substring(uniqueString(utcNow()),0,6)
param appGateways array
param adminUsername string
@secure()
param adminPassword string
param location string 

targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'aio-p10b-app-gateway'
  location: location
}

module deploy_appgw '../../bicep-core/appgw.bicep' = [for appGateway in appGateways: {
  name: 'Def-${appGateway.name}-${deploymentid}'
  scope: rg
  params: {
    adminUsername: adminUsername    
    adminPassword: adminPassword
    location: appGateway.location
    vmSize: appGateway.vmsize
  }
}]
