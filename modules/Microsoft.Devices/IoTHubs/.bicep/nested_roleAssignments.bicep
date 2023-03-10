@sys.description('Required. The IDs of the principals to assign the role to.')
param principalIds array

@sys.description('Required. The name of the role to assign. If it cannot be found you can specify the role definition ID instead.')
param roleDefinitionIdOrName string

@sys.description('Required. The resource ID of the resource to apply the role assignment to.')
param resourceId string

@sys.description('Optional. The principal type of the assigned principal ID.')
@allowed([
  'ServicePrincipal'
  'Group'
  'User'
  'ForeignGroup'
  'Device'
  ''
])
param principalType string = ''

@sys.description('Optional. The description of the role assignment.')
param description string = ''

@sys.description('Optional. The conditions on the role assignment. This limits the resources it can be assigned to. e.g.: @Resource[Microsoft.Storage/storageAccounts/blobServices/containers:ContainerName] StringEqualsIgnoreCase "foo_storage_container"')
param condition string = ''

@sys.description('Optional. Version of the condition.')
@allowed([
  '2.0'
])
param conditionVersion string = '2.0'

@sys.description('Optional. Id of the delegated managed identity resource.')
param delegatedManagedIdentityResourceId string = ''

var builtInRoleNames = {
  'IoT Hub Data Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '4fc6c259-987e-4a07-842e-c321cc9d413f')
  'Storage Blob Data Contributor': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'ba92f5b4-2d11-453d-a403-e96b0029c9fe')
  'Azure Event Hubs Data Sender': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '2b629674-e913-4c01-ae53-ef4638d8f975')
  'Azure Service Bus Data Sender': subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '69a216fc-b8fb-44d8-bc22-1f3c2cd27a39')
}

var resourceGroupName = resourceGroup().name
var iotHubResourceName = '${last(split(resourceId, '/'))}'

resource iothub 'Microsoft.Devices/IotHubs@2021-07-02' existing = {
  name: iotHubResourceName
}

resource roleAssignment 'Microsoft.Authorization/roleAssignments@2020-10-01-preview' = [for principalId in principalIds: {
  name: guid(iothub.id, resourceGroupName, roleDefinitionIdOrName, principalId)
  properties: {
    description: description
    roleDefinitionId: contains(builtInRoleNames, roleDefinitionIdOrName) ? builtInRoleNames[roleDefinitionIdOrName] : roleDefinitionIdOrName
    principalId: principalId
    principalType: !empty(principalType) ? any(principalType) : null
    condition: !empty(condition) ? condition : null
    conditionVersion: !empty(conditionVersion) && !empty(condition) ? conditionVersion : null
    delegatedManagedIdentityResourceId: !empty(delegatedManagedIdentityResourceId) ? delegatedManagedIdentityResourceId : null
  }
  scope: resourceGroup()
}]
