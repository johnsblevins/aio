param deploymentid string = substring(uniqueString(utcNow()),0,6)
param imagegalleries array
param location string

targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'aio-p12-image-gallery'
  location: location
}

module deploy_imagegalleries '../../bicep-core/imagegallery.bicep' = [for imagegallery in imagegalleries: {
  name: 'Def-${imagegallery.name}-${deploymentid}'
  scope: rg
  params: {
    location: imagegallery.location
    _artifactsLocation: imagegallery._artifactsLocation
    _artifactsLocationSasToken: imagegallery._artifactsLocationSasToken
  }
}]
