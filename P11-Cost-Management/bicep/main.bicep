param deploymentid string = substring(uniqueString(utcNow()),0,6)
param actiongroups array
param budgets array
param location string

targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'aio-p11-cost-management'
  location: location
}

module deploy_actiongroups '../../bicep-core/actiongroup.bicep' = [for actiongroup in actiongroups: {
  name: 'Def-${actiongroup.actiongroupName}-${deploymentid}'
  scope: rg
  params: {
    actionGroupName: actiongroup.actionGroupName
    actionGroupShortName: actiongroup.actionGroupShortName
    emailReceivers: actiongroup.emailReceivers
    smsReceivers: actiongroup.smsReceivers
  }
}]

module deploy_budgets '../../bicep-core/budget.bicep' = [for budget in budgets: {
  name: 'Def-${budget.budgetName}-${deploymentid}'
  params: {
    endDate: budget.endDate
    contactGroups: [for (name, i) in actiongroups: deploy_actiongroups[i].outputs.actionGroupId]
    contactEmails: budget.contactEmails
    resourceGroupFilterValues: budget.resourceGroupFilterValues
    startDate: budget.startDate
    meterCategoryFilterValues: budget.meterCategoryFilterValues
  }
  dependsOn: [
    deploy_actiongroups
  ]
}]
