# 
1. Update .\P8-Azure-RBAC\parameters\main.parameters.json
```
{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "roleDefinitions": {
            "value": [
                {
                    "name": "417b460e-4f30-5598-a1e8-e9a44c896f83",
                    "roleName": "Custom Virtual Machine Contributor",
                    "description": "Custom role for deploying virtual machines.",
                    "permissions": [
                        {
                            "actions": [
                                "Microsoft.Authorization/*/read",
                                ...
                            ],
                            "dataActions": [],
                            "notActions": [],
                            "notDataActions": []
                        }
                    ],
                    "assignableScopes": [
                        "/subscriptions/<subscription id>"
                    ],                    
                    "type": "Microsoft.Authorization/roleDefinitions"                 
                }
            ]            
        },
        "roleAssignments": {
            "value": [
                {
                    "name": "Custom-Virtual-Machine-Contributor",
                    "principalId": "36805b3f-52fb-4452-ba0b-085de56bf023",
                    "roleDefinitionId": "417b460e-4f30-5598-a1e8-e9a44c896f83"
                },
                {
                    "name": "Virtual-Machine-Contributor",
                    "principalId": "36805b3f-52fb-4452-ba0b-085de56bf023",
                    "roleDefinitionId": "9980e02c-c2be-4d73-94e8-173b1dc7cf3c"
                }
            ]
        }
    }
}
```
2. Deploy the template
```
cd .\P8-Azure-RBAC\scripts\
.\deploy-bicep.ps1 -environment <Azure Environment> -location <Azure Region> -subscriptionid <subscription id guid> 
```