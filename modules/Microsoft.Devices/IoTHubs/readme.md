# Azure IoTHub 0.1 `[Microsoft.Devices/IoTHubs]`

## Navigation

- [Release Notes](#Release-Notes)
- [Resource types](#Resource-types)
- [Parameters](#Parameters)
- [Outputs](#Outputs)
- [Cross-referenced modules](#Cross-referenced-modules)
- [Deployment examples](#Deployment-examples)

## Release Notes

| Date | Description |
| :-- | :-- |
| 2022.01.12 | Initial version |
| 2023.01.25 | Revised version |

Initial version of Azure IoTHub resource with the following parameters enabled:

## Resource types

| Resource Type | API Version |
| :-- | :-- |
| `Microsoft.Authorization/roleAssignments` | [2020-10-01-preview](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Authorization/2020-10-01-preview/roleAssignments) |
| `Microsoft.Devices/IotHubs` | [2021-07-02](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Devices/2021-07-02/IotHubs) |

## Parameters

**Required parameters**

| Parameter Name | Type | Description |
| :-- | :-- | :-- |
| `name` | string | String. The IoT hub name to deploy. Max length is 11. |

**Optional parameters**

| Parameter Name | Type | Default Value | Allowed Values | Description |
| :-- | :-- | :-- | :-- | :-- |
| `d2cPartitions` | int | `2` |  | Integer. Partition count used for the event stream. Value between 2 and 128. |
| `eventRetentionDays` | int | `1` |  | String. The amount of retention days of messages in event hub [ events ]. Default 1 day. |
| `iotCloudToDeviceObject` | object | `{object}` |  | Object. Specify any c2d parameters for this IoTHub instance, like maxDeliveryCount, defaultTlsasIso8601, etc. |
| `iotEnableFileUploadNotifications` | bool | `False` |  | Bool. Enable or Disable File upload Notifications. Default= false. |
| `iotEventHubsObject` | array | `[]` |  | Array. EventHub  endpoint within this IoTHub instance. |
| `iotFallBackRouteObject` | object | `{object}` |  | Object. The Fallback Routing definition within this IoTHub instance. |
| `iotLocalAuth` | bool | `False` |  | Bool. Allow or disallow Local Auth to this IoT Hub. Default value: false. |
| `iotMessagingEndpointsObject` | object | `{object}` |  | Object. The Fallback Routing definition within this IoTHub instance. |
| `iotPublicAccess` | string | `'Enabled'` | `[Disabled, disabled, Enabled, enabled]` | String. Enable or Disable public access to this IoT Hub. Default value: Enabled. |
| `iotRouteObject` | array | `[]` |  | Array. The Routing definition(s) within this IoTHub instance. |
| `iotServiceBusQueuesObject` | array | `[]` |  | Array. ServiceBusQueue  endpoint within this IoTHub instance. |
| `iotServiceBusTopicsObject` | array | `[]` |  | Array. ServiceBusTopics  endpoint within this IoTHub instance. |
| `iotSkuTier` | string | `'S1'` | `[B1, B2, B3, S1, S2, S3]` | String. The SKU to use for the IoT Hub. You can downsize the number of Units but not the Tier. Default value: S1. |
| `iotSkuUnits` | int | `1` |  | Integer. The number of IoT Hub units within the chosen Tier. Do not exceed 4. Default value: 1. |
| `iotStorageContainersObject` | array | `[]` |  | Array. StorageContainers endpoint within this IoTHub instance. |
| `location` | string | `[resourceGroup().location]` |  | String. The Location to use for the deployment. Default value is resourceGroup().location . |
| `tags` | object | `{object}` |  | Tags of the IoTHub resource. |


### Parameter Usage: `tags`

Tag names and tag values can be provided as needed. A tag can be left without a value.

<details>

<summary>Parameter JSON format</summary>

```json
"tags": {
    "value": {
        "Environment": "Non-Prod",
        "Contact": "test.user@testcompany.com",
        "PurchaseOrder": "1234",
        "CostCenter": "7890",
        "ServiceName": "DeploymentValidation",
        "Role": "DeploymentValidation"
    }
}
```

</details>

<details>

<summary>Bicep format</summary>

```bicep
tags: {
    Environment: 'Non-Prod'
    Contact: 'test.user@testcompany.com'
    PurchaseOrder: '1234'
    CostCenter: '7890'
    ServiceName: 'DeploymentValidation'
    Role: 'DeploymentValidation'
}
```

</details>

## Outputs

| Output Name | Type | Description |
| :-- | :-- | :-- |
| `location` | string | Location. |
| `name` | string | Resource Name. |
| `resourceGroupName` | string | Resource Group Name. |
| `resourceId` | string | Resource Id. |
| `systemAssignedPrincipalId` | string | The principal ID of the system assigned identity. |

## Cross-referenced modules

_None_

## Deployment examples

The following module usage examples are retrieved from the content of the files hosted in the module's `.test` folder.
   >**Note**: The name of each example is based on the name of the file from which it is taken.

   >**Note**: Each example lists all the required parameters first, followed by the rest - each in alphabetical order.

<h3>Example 1: Min Test</h3>

<details>

<summary>via Bicep module</summary>

```bicep
module IoTHubs './Microsoft.Devices/IoTHubs/deploy.bicep' = {
  name: '${uniqueString(deployment().name)}-IoTHubs'
  params: {
    // Required parameters
    name: 'minimalHub'
    // Non-required parameters
    iotSkuTier: 'S1'
    iotSkuUnits: 1
    tags: {
      applicationid: 'sampleiot'
      costcenter: '555666'
      environment: 'sandbox'
      orderid: 'Order-2020-05'
    }
  }
}
```

</details>
<p>

<details>

<summary>via JSON Parameter file</summary>

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    // Required parameters
    "name": {
      "value": "minimalHub"
    },
    // Non-required parameters
    "iotSkuTier": {
      "value": "S1"
    },
    "iotSkuUnits": {
      "value": 1
    },
    "tags": {
      "value": {
        "applicationid": "sampleiot",
        "costcenter": "555666",
        "environment": "sandbox",
        "orderid": "Order-2020-05"
      }
    }
  }
}
```

</details>
<p>

<h3>Example 2: Typical Test</h3>

<details>

<summary>via Bicep module</summary>

```bicep
module IoTHubs './Microsoft.Devices/IoTHubs/deploy.bicep' = {
  name: '${uniqueString(deployment().name)}-IoTHubs'
  params: {
    // Required parameters
    name: 'myuniqueHub'
    // Non-required parameters
    d2cPartitions: 2
    iotCloudToDeviceObject: {
      defaultTtlAsIso8601: 'PT1H'
      feedback: {
        lockDurationAsIso8601: 'PT1M'
        maxDeliveryCount: 10
        ttlAsIso8601: 'PT1H'
      }
      maxDeliveryCount: 10
    }
    iotEnableFileUploadNotifications: false
    iotFallbackRouteObject: {
      condition: 'true'
      endpointNames: [
        'events'
      ]
      isEnabled: true
      name: '$fallback'
      source: 'DeviceMessages'
    }
    iotMessagingEndpointsObject: {
      fileNotifications: {
        lockDurationAsIso8601: 'PT1M'
        maxDeliveryCount: 100
        ttlAsIso8601: 'PT1H'
      }
    }
    iotPublicAccess: 'Enabled'
    iotRouteObject: [
      {
        condition: 'level = \'storage\''
        endpointNames: [
          'demoroute'
        ]
        isEnabled: true
        name: 'DemoStorageRoute'
        source: 'DeviceMessages'
      }
      {
        condition: null
        endpointNames: [
          'pnproute'
        ]
        isEnabled: true
        name: 'IoTPnPRoute'
        source: 'DeviceMessages'
      }
    ]
    iotSkuTier: 'S1'
    iotSkuUnits: 1
    iotStorageContainersObject: [
      {
        authenticationType: 'identityBased'
        batchFrequencyInSeconds: 100
        containerName: 'datademo'
        encoding: 'avro'
        endpointUri: 'https://pxssptssa1.blob.core.windows.net/'
        fileNameFormat: '{iothub}/{partition}/{YYYY}/{MM}/{DD}/{HH}/{mm}'
        maxChunkSizeInBytes: 104857600
        name: 'demoroute'
        resourceGroup: 'validation-rg'
        subscriptionId: '<<subscriptionId>>'
      }
      {
        authenticationType: 'identityBased'
        batchFrequencyInSeconds: 100
        containerName: 'iotplugandplay'
        encoding: 'avro'
        endpointUri: 'https://pxssptssa1.blob.core.windows.net/'
        fileNameFormat: '{iothub}/{partition}/{YYYY}/{MM}/{DD}/{HH}/{mm}'
        maxChunkSizeInBytes: 104857600
        name: 'pnproute'
        resourceGroup: 'validation-rg'
        subscriptionId: '<<subscriptionId>>'
      }
    ]
    location: 'West Europe'
    tags: {
      applicationid: 'sampleiot'
      costcenter: '555666'
      environment: 'sandbox'
      orderid: 'Order-2020-05'
    }
  }
}
```

</details>
<p>

<details>

<summary>via JSON Parameter file</summary>

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    // Required parameters
    "name": {
      "value": "myuniqueHub"
    },
    // Non-required parameters
    "d2cPartitions": {
      "value": 2
    },
    "iotCloudToDeviceObject": {
      "value": {
        "defaultTtlAsIso8601": "PT1H",
        "feedback": {
          "lockDurationAsIso8601": "PT1M",
          "maxDeliveryCount": 10,
          "ttlAsIso8601": "PT1H"
        },
        "maxDeliveryCount": 10
      }
    },
    "iotEnableFileUploadNotifications": {
      "value": false
    },
    "iotFallbackRouteObject": {
      "value": {
        "condition": "true",
        "endpointNames": [
          "events"
        ],
        "isEnabled": true,
        "name": "$fallback",
        "source": "DeviceMessages"
      }
    },
    "iotMessagingEndpointsObject": {
      "value": {
        "fileNotifications": {
          "lockDurationAsIso8601": "PT1M",
          "maxDeliveryCount": 100,
          "ttlAsIso8601": "PT1H"
        }
      }
    },
    "iotPublicAccess": {
      "value": "Enabled"
    },
    "iotRouteObject": {
      "value": [
        {
          "condition": "level = \"storage\"",
          "endpointNames": [
            "demoroute"
          ],
          "isEnabled": true,
          "name": "DemoStorageRoute",
          "source": "DeviceMessages"
        },
        {
          "condition": null,
          "endpointNames": [
            "pnproute"
          ],
          "isEnabled": true,
          "name": "IoTPnPRoute",
          "source": "DeviceMessages"
        }
      ]
    },
    "iotSkuTier": {
      "value": "S1"
    },
    "iotSkuUnits": {
      "value": 1
    },
    "iotStorageContainersObject": {
      "value": [
        {
          "authenticationType": "identityBased",
          "batchFrequencyInSeconds": 100,
          "containerName": "datademo",
          "encoding": "avro",
          "endpointUri": "https://pxssptssa1.blob.core.windows.net/",
          "fileNameFormat": "{iothub}/{partition}/{YYYY}/{MM}/{DD}/{HH}/{mm}",
          "maxChunkSizeInBytes": 104857600,
          "name": "demoroute",
          "resourceGroup": "validation-rg",
          "subscriptionId": "<<subscriptionId>>"
        },
        {
          "authenticationType": "identityBased",
          "batchFrequencyInSeconds": 100,
          "containerName": "iotplugandplay",
          "encoding": "avro",
          "endpointUri": "https://pxssptssa1.blob.core.windows.net/",
          "fileNameFormat": "{iothub}/{partition}/{YYYY}/{MM}/{DD}/{HH}/{mm}",
          "maxChunkSizeInBytes": 104857600,
          "name": "pnproute",
          "resourceGroup": "validation-rg",
          "subscriptionId": "<<subscriptionId>>"
        }
      ]
    },
    "location": {
      "value": "West Europe"
    },
    "tags": {
      "value": {
        "applicationid": "sampleiot",
        "costcenter": "555666",
        "environment": "sandbox",
        "orderid": "Order-2020-05"
      }
    }
  }
}
```

</details>
