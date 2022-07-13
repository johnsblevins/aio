param deploymentid string = substring(uniqueString(utcNow()),0,6)
param roledefinitions array
param roleassignments array

targetScope = 'subscription'

module deploy_roledefinitions '../../bicep-core/roledefinition.bicep' = [for roledefinition in roledefinitions: {
  name: 'Def-${roledefinition.name}-${deploymentid}'
  scope: subscription()
  params: {
    name: roledefinition.name
    permissions: roledefinition.permissions
    description: roledefinition.description
    roleName: roledefinition.roleName
    assignableScopes: roledefinition.assignableScopes
  }
}]

module deploy_roleassignments '../../bicep-core/roleassignment.bicep' = [for roleassignment in roleassignments: {
  name: 'Assign-${guid(roleassignment.roleDefinitionId, roleassignment.principalId, subscription().id)}-${deploymentid}'
  scope: subscription()
  dependsOn: [
    deploy_roledefinitions
  ]
  params: {
    name: guid(roleassignment.roleDefinitionId, roleassignment.principalId, subscription().id)
    principalId: roleassignment.principalId
    roleDefinitionId: '/providers/Microsoft.Authorization/roleDefinitions/${roleassignment.roleDefinitionId}'
  }
}]
