param appServiceName string
param appServicePlanSkuName string
param location string

resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: 'MyAppServicePlan'
  location: location
  sku: {
    name: appServicePlanSkuName
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

output appServiceHostName string = appService.properties.defaultHostName
