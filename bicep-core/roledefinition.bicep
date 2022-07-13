param name string
param assignableScopes array
param description string
param permissions array
param roleName string

targetScope = 'subscription'

resource roledefinition 'Microsoft.Authorization/roleDefinitions@2018-01-01-preview' = {
  name: name  
  properties: {
    assignableScopes: assignableScopes
    description: description
    permissions: permissions
    roleName: roleName
  } 
}
