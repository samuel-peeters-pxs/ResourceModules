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
| `Microsoft.Authorization/roleAssignments` | [2020-10-01-preview](https://docs.microsoft.com/en-us/azure/templates/Microsoft.Authorization/2020-10-01-preview/roleAssignments) |
| `Microsoft.Devices/IotHubs` | [2021-07-02](https://docs.microsoft.com/en-us/azure/templates/Microsoft.Devices/2021-07-02/IotHubs) |

## Parameters

**Required parameters**

| Parameter Name | Type | Description |
| :-- | :-- | :-- |
| `name` | string | String. The IoT hub name to deploy. Max length is 11. |

**Optional parameters**

| Parameter Name | Type | Default Value | Allowed Values | Description |
| :-- | :-- | :-- | :-- | :-- |
| `d2cPartitions` | int | `2` |  | Integer. Partition count used for the event stream. Value between 2 and 128. |
| `disableDeviceSAS` | bool | `False` |  | Bool. Disable Device SAS Auth to this IoT Hub. Default value: false. |
| `disableLocalAuth` | bool | `True` |  | Bool. Disable Local Auth to this IoT Hub. Default value: true. |
| `disableModuleSAS` | bool | `False` |  | Bool. Disable Module SAS Auth to this IoT Hub. Default value: false. |
| `enableDefaultTelemetry` | bool | `True` |  | Enable telemetry via a Globally Unique Identifier (GUID). |
| `enableFileUploadNotifications` | bool | `False` |  | Bool. Enable or Disable File upload Notifications. Default= false. |
| `eventRetentionDays` | int | `1` |  | String. The amount of retention days of messages in event hub [ events ]. Default 1 day. |
| `iotCloudToDeviceObject` | object | `{object}` |  | Object. Specify any c2d parameters for this IoTHub instance, like maxDeliveryCount, defaultTlsasIso8601, etc. |
| `iotEventHubsObject` | array | `[]` |  | Array. EventHub  endpoint within this IoTHub instance. |
| `iotFallBackRouteObject` | object | `{object}` |  | Object. The Fallback Routing definition within this IoTHub instance. |
| `iotMessagingEndpointsObject` | object | `{object}` |  | Object. The Fallback Routing definition within this IoTHub instance. |
| `iotRouteObject` | array | `[]` |  | Array. The Routing definition(s) within this IoTHub instance. |
| `iotServiceBusQueuesObject` | array | `[]` |  | Array. ServiceBusQueue  endpoint within this IoTHub instance. |
| `iotServiceBusTopicsObject` | array | `[]` |  | Array. ServiceBusTopics  endpoint within this IoTHub instance. |
| `iotStorageContainersObject` | array | `[]` |  | Array. StorageContainers endpoint within this IoTHub instance. |
| `location` | string | `[resourceGroup().location]` |  | String. The Location to use for the deployment. Default value is resourceGroup().location . |
| `publicAccess` | string | `'Enabled'` | `[Disabled, disabled, Enabled, enabled]` | String. Enable or Disable public access to this IoT Hub. Default value: Enabled. |
| `skuTier` | string | `'S1'` | `[B1, B2, B3, S1, S2, S3]` | String. The SKU to use for the IoT Hub. You can downsize the number of Units but not the Tier. Default value: S1. |
| `skuUnits` | int | `1` |  | Integer. The number of IoT Hub units within the chosen Tier. Do not exceed 4. Default value: 1. |
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
<p>

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

<h3>Example 1: Min</h3>

<details>

<summary>via Bicep module</summary>

```bicep
module IoTHubs './Microsoft.Devices/IoTHubs/deploy.bicep' = {
  name: '${uniqueString(deployment().name)}-IoTHubs'
  params: {
    // Required parameters
    name: '3FdsdbxDe4f'
    // Non-required parameters
    skuTier: 'S1'
    skuUnits: 1
    tags: {
      applicationid: 'iot'
      environment: 'sandbox'
      costcenter: 'development'
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
      "value": "3FdsdbxDe4f"
    },
    // Non-required parameters
    "skuTier": {
      "value": "S1"
    },
    "skuUnits": {
      "value": 1
    },
    "tags": {
      "value": {
        "applicationid": "iot",
        "costcenter": "development",
        "environment": "sandbox"
      }
    }
  }
}
```

</details>
<p>

<h3>Example 2: Typical</h3>

<details>

<summary>via Bicep module</summary>

```bicep
module IoTHubs './Microsoft.Devices/IoTHubs/deploy.bicep' = {
  name: '${uniqueString(deployment().name)}-IoTHubs'
  params: {
    // Required parameters
    name: '3FdsdbxDe4f'
    // Non-required parameters
    d2cPartitions: 2
    enableFileUploadNotifications: false
    iotCloudToDeviceObject: {
      defaultTtlAsIso8601: 'PT1H'
      feedback: {
        lockDurationAsIso8601: 'PT1M'
        maxDeliveryCount: 10
        ttlAsIso8601: 'PT1H'
      }
      maxDeliveryCount: 10
    }
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
    iotRouteObject: [
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
    iotStorageContainersObject: [
      {
        authenticationType: 'identityBased'
        batchFrequencyInSeconds: 100
        containerName: 'iotplugandplay'
        encoding: 'avro'
        endpointUri: 'https://3FdsdbxDe4f.blob.core.windows.net/'
        fileNameFormat: '{iothub}/{partition}/{YYYY}/{MM}/{DD}/{HH}/{mm}'
        maxChunkSizeInBytes: 104857600
        name: 'pnproute'
        resourceGroup: 'validation-rg'
        subscriptionId: '<<subscriptionId>>'
      }
    ]
    location: 'West Europe'
    publicAccess: 'Enabled'
    skuTier: 'S1'
    skuUnits: 1
    tags: {
      applicationid: 'iot'
      costcenter: 'development'
      environment: 'sandbox'
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
      "value": "3FdsdbxDe4f"
    },
    // Non-required parameters
    "d2cPartitions": {
      "value": 2
    },
    "enableFileUploadNotifications": {
      "value": false
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
    "iotRouteObject": {
      "value": [
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
    "iotStorageContainersObject": {
      "value": [
        {
          "authenticationType": "identityBased",
          "batchFrequencyInSeconds": 100,
          "containerName": "iotplugandplay",
          "encoding": "avro",
          "endpointUri": "https://3FdsdbxDe4f.blob.core.windows.net/",
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
    "publicAccess": {
      "value": "Enabled"
    },
    "skuTier": {
      "value": "S1"
    },
    "skuUnits": {
      "value": 1
    },
    "tags": {
      "value": {
        "applicationid": "iot",
        "costcenter": "development",
        "environment": "sandbox"
      }
    }
  }
}
```

</details>
<p>
