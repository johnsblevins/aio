param location string
param rgname string
param vmname string
param adminUsername string
param linuxOSOffer string
param linuxOSVersion string
param linuxOSPublisher string
param linuxOSSku string

@secure()
param adminPasswordOrKey string


param deploymentId string = substring(uniqueString(utcNow()),0,6)

targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01'={
  location: location
  name: rgname
}

module vm 'vm.bicep'={
  name: 'deploy-${vmname}-${deploymentId}'
  params: {
    vmName: vmname
    location: rg.location
    adminUsername: adminUsername
    linuxOSOffer: linuxOSOffer
    linuxOSVersion: linuxOSVersion
    adminPasswordOrKey: adminPasswordOrKey
    linuxOSPublisher: linuxOSPublisher
    linuxOSSku: linuxOSSku    
  }
  scope: rg  
}

output adminUsername string = vm.outputs.adminUsername
output hostname string = vm.outputs.hostname
output sshCommand string = vm.outputs.sshCommand
