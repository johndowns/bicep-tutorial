param storageAccountName string = 'stor${uniqueString(resourceGroup().id)}'
param appServiceName string = 'mywebapp${uniqueString(resourceGroup().id)}'
param location string = resourceGroup().location
param environment string {
  allowed: [
    'Development'
    'Production'
  ]
}

var storageAccountSkuName = (environment == 'Production') ? 'Standard_GRS' : 'Standard_LRS'
var appServicePlanSkuName = 'S1'

resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountSkuName
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

module appService 'app-service.bicep' = {
  name: 'app-service'
  params: {
    location: location
    appServiceName: appServiceName
    appServicePlanSkuName: appServicePlanSkuName
  }
}

output appServiceHostName string = appService.outputs.appServiceHostName
