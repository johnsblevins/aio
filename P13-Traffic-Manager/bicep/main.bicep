param deploymentid string = substring(uniqueString(utcNow()),0,6)
param trafficManagers array
param adminUsername string
@secure()
param adminPassword string
param location string 

targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'aio-p13-traffic-manager'
  location: location
}

module deploy_trafficManager '../../bicep-core/trafficmanager.bicep' = [for trafficManager in trafficManagers: {
  name: 'Def-${trafficManager.name}-${deploymentid}'
  scope: rg
  params: {
    adminUsername: adminUsername
    adminPassword: adminPassword
    primarylocation: trafficManager.primaryLocation
    secondarylocation: trafficManager.secondaryLocation
    artifactsLocation: trafficManager.artifactsLocation
    artifactsLocationSasToken: trafficManager.artifactsLocationSasToken   
    name: trafficManager.name 
    trafficRoutingMethod: trafficManager.trafficRoutingMethod
  }
}]
