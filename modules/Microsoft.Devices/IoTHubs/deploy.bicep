@description('Required. String. The IoT hub name to deploy. Max length is 11.')
@maxLength(11)
@minLength(1)
param name string

@description('Optional. String. The Location to use for the deployment. Default value is resourceGroup().location .')
param location string = resourceGroup().location

@description('Optional. String. The SKU to use for the IoT Hub. You can downsize the number of Units but not the Tier. Default value: S1.')
@allowed([
    'S1'
    'S2'
    'S3'
    'B1'
    'B2'
    'B3'
])
param iotSkuTier string = 'S1'

@description('Optional. Integer. The number of IoT Hub units within the chosen Tier. Do not exceed 4. Default value: 1.')
@minValue(1)
@maxValue(4)
param iotSkuUnits int = 1

@description('Optional. String. Enable or Disable public access to this IoT Hub. Default value: Enabled.')
@allowed([
    'Enabled'
		'enabled'
		'Disabled'
		'disabled'
])
param iotPublicAccess string = 'Enabled'

@description('Optional. Bool. Allow or disallow Local Auth to this IoT Hub. Default value: false.')
param iotLocalAuth bool = false

@description('Optional. Integer. Partition count used for the event stream. Value between 2 and 128.')
@minValue(2)
@maxValue(128)
param d2cPartitions int = 2

@description('Optional. String. The amount of retention days of messages in event hub [ events ]. Default 1 day.')
param eventRetentionDays int = 1

@description('Optional. Array. ServiceBusTopics  endpoint within this IoTHub instance.')
param iotServiceBusTopicsObject array = []

@description('Optional. Array. EventHub  endpoint within this IoTHub instance.')
param iotEventHubsObject array = []

@description('Optional. Array. ServiceBusQueue  endpoint within this IoTHub instance.')
param iotServiceBusQueuesObject array = []

@description('Optional. Array. StorageContainers endpoint within this IoTHub instance.')
param iotStorageContainersObject array = []

@description('Optional. Array. The Routing definition(s) within this IoTHub instance.')
param iotRouteObject array = []

@description('Optional. Object. The Fallback Routing definition within this IoTHub instance.')
param iotFallBackRouteObject object = {}

@description('Optional. Object. The Fallback Routing definition within this IoTHub instance.')
param iotMessagingEndpointsObject object = {}

@description('Optional. Bool. Enable or Disable File upload Notifications. Default= false.')
param iotEnableFileUploadNotifications bool = false

@description('Optional. Object. Specify any c2d parameters for this IoTHub instance, like maxDeliveryCount, defaultTlsasIso8601, etc.')
param iotCloudToDeviceObject object = {}

@description('Optional. Tags of the IoTHub resource.')
param tags object = {}

var enableFileUploadNotifications = empty(iotStorageContainersObject) ? false : iotEnableFileUploadNotifications
var iotEmptyArrayObject = []
var iotServiceBusQueuesVariable = empty(iotServiceBusQueuesObject) ? iotEmptyArrayObject : iotServiceBusQueuesObject
var ioTserviceBusTopicsVariable = empty(iotServiceBusTopicsObject) ? iotEmptyArrayObject : iotServiceBusTopicsObject
var ioTEventHubsVariable = empty(iotEventHubsObject) ? iotEmptyArrayObject : iotEventHubsObject
var ioTStorageContainersVariable = empty(iotStorageContainersObject) ? iotEmptyArrayObject : iotStorageContainersObject
var ioTHubName = name

var roleAssignments = [
  {
    description: 'Allow IoTHub for Service Bus Data Sender'
    roleDefinitionIdOrName: 'Azure Service Bus Data Sender'
  }
  {
    description: 'Allow IoTHub for Event Hubs Data Sender'
    roleDefinitionIdOrName: 'Azure Event Hubs Data Sender'
  }
  {
    description: 'Allow IoTHub for Storage Blob Data Contributor'
    roleDefinitionIdOrName: 'Storage Blob Data Contributor'
  }
  {
    description: 'Allow IoTHub for IoT Hub Data Contributor'
    roleDefinitionIdOrName: 'IoT Hub Data Contributor'
  }
]

module minimal_iothub '.bicep/minimal_iothub.bicep' = {
  name: '${uniqueString(deployment().name, location)}-minimalIoTHub-minimal-0'
  params: {
    name: ioTHubName
    location: location
    iotSkuTier: iotSkuTier
    iotSkuUnits: iotSkuUnits
    iotPublicAccess: iotPublicAccess
    d2cPartitions: d2cPartitions
    eventRetentionDays: eventRetentionDays
    tags: tags
  }
}

module iothub_roleassignments '.bicep/nested_roleAssignments.bicep' = [for (roleAssignment, index) in roleAssignments: {
  name: '${uniqueString(deployment().name, location)}-IotHub-Rbac-${index}'
  params: {
    description: contains(roleAssignment, 'description') ? roleAssignment.description : ''
    principalIds: [
        minimal_iothub.outputs.principalId
    ]
    principalType: 'ServicePrincipal' // See https://docs.microsoft.com/azure/role-based-access-control/role-assignments-template#new-service-principal to understand why this property is included.
    roleDefinitionIdOrName: roleAssignment.roleDefinitionIdOrName
    condition: contains(roleAssignment, 'condition') ? roleAssignment.condition : ''
    delegatedManagedIdentityResourceId: contains(roleAssignment, 'delegatedManagedIdentityResourceId') ? roleAssignment.delegatedManagedIdentityResourceId : ''
    resourceId: minimal_iothub.outputs.resourceId
  }
}]

resource iothub 'Microsoft.Devices/IotHubs@2021-07-02' = {
  name: ioTHubName
  location: location
  tags: tags
  sku: {
    capacity: iotSkuUnits
    name: iotSkuTier
  }
  properties: {
    publicNetworkAccess: iotPublicAccess
    disableLocalAuth: iotLocalAuth
    disableDeviceSAS: true
    disableModuleSAS: true
    eventHubEndpoints: {
      events: {
        retentionTimeInDays: eventRetentionDays
        partitionCount: d2cPartitions
      }
    }
    routing: {
      endpoints: {
        serviceBusQueues: iotServiceBusQueuesVariable
        serviceBusTopics: ioTserviceBusTopicsVariable
        eventHubs: ioTEventHubsVariable
        storageContainers: ioTStorageContainersVariable
      }
      routes: !empty(iotRouteObject) ? iotRouteObject : null
      fallbackRoute: !empty(iotFallBackRouteObject) ? iotFallBackRouteObject : null
    }
    messagingEndpoints: iotMessagingEndpointsObject
    enableFileUploadNotifications: enableFileUploadNotifications
    cloudToDevice: iotCloudToDeviceObject
  }
  identity: {
    type: 'SystemAssigned'
  }
  dependsOn: [
    iothub_roleassignments
  ]
}

@description('Resource Name.')
output name string = iothub.name

@description('Location.')
output location string = iothub.location

@description('Resource Group Name.')
output resourceGroupName string = resourceGroup().name

@description('Resource Id.')
output resourceId string = iothub.id

@description('The principal ID of the system assigned identity.')
output systemAssignedPrincipalId string = iothub.identity.principalId
