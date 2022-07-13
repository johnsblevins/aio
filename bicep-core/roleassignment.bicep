param name string
param principalId string
param roleDefinitionId string
param description string = ''
param principalType string = ''
param delegatedManagedIdentityResourceId string = ''

targetScope = 'subscription'

resource roleassignment 'Microsoft.Authorization/roleAssignments@2020-10-01-preview' = {
  name: name
  properties: {
    principalId: principalId
    roleDefinitionId: roleDefinitionId
    description: description
    principalType: principalType
    delegatedManagedIdentityResourceId: delegatedManagedIdentityResourceId
  }
}
