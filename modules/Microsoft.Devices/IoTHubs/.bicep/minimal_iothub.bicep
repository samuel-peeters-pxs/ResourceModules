@description('Required. The IoT hub name to deploy.')
@maxLength(11)
@minLength(1)
param name string

@description('Optional. The Location to use for the deployment. By default takes same location as resourceGroup().location')
param location string = resourceGroup().location

@description('Optional. The SKU to use for the IoT Hub, string. You can downsize the number of Units but not the Tier. Default value: S1')
@allowed([
    'S1'
    'S2'
    'S3'
    'B1'
    'B2'
    'B3'
])
param iotSkuTier string = 'S1'

@description('Optional. The number of IoT Hub units within the chosen Tier, integer. Do not exceed 4. Default value: 1')
@minValue(1)
@maxValue(4)
param iotSkuUnits int = 1

@description('Optional,  string. Enable or Disable public access to this IoT Hub, string representation. Default value: Enabled.')
@allowed([
    'Enabled'
		'enabled'
		'Disabled'
		'disabled'
])
param iotPublicAccess string = 'Enabled'

@description('Optional. Partition count used for the event stream. Value between 2 and 128.')
@minValue(2)
@maxValue(128)
param d2cPartitions int = 2

@description('Optional. String number representation for the amount of retention days of messages in event hub [events]. Default 1 day.')
param eventRetentionDays int = 1

@description('Optional. Tags of the IoTHub resource.')
param tags object = {}

resource minimum_iothub 'Microsoft.Devices/IotHubs@2021-07-02' = {
  name: name
  location: location
  tags: tags
  sku: {
    capacity: iotSkuUnits
    name: iotSkuTier
  }
  properties: {
    publicNetworkAccess: iotPublicAccess
    eventHubEndpoints: {
      events: {
        retentionTimeInDays: eventRetentionDays
        partitionCount: d2cPartitions
      }
    }
   }
  identity: {
    type: 'SystemAssigned'
  }
}

@description('String representing Managed identity id assigned to this IoT Hub.')
output principalId string = minimum_iothub.identity.principalId

@description('String representing the resourceId for this IoT Hub.')
output resourceId string = minimum_iothub.id
