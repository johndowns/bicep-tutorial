param storageAccountName string = 'stor${uniqueString(resourceGroup().id)}'
param appServiceName string = 'mywebapp${uniqueString(resourceGroup().id)}'
param location string = resourceGroup().location
param environment string {
  allowed: [
    'Development'
    'Production'
  ]
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: (environment == 'Production') ? 'Standard_GRS' : 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: 'MyAppServicePlan'
  location: location
  sku: {
    name: 'S1'
  }
}

resource appService 'Microsoft.Web/sites@2020-06-01' = {
  name: appServiceName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}
