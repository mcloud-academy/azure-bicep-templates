@description('The name of the SQL logical server.')
param serverName string = uniqueString('sql', resourceGroup().id)

@description('The name of the SQL Database.')
param sqlDBName string = 'SampleDB'

@description('Location for all resources.')
param location string = resourceGroup().location

@description('The administrator username of the SQL logical server.')
param administratorLogin string

@description('The administrator password of the SQL logical server.')
@secure()
param administratorLoginPassword string

resource sqlServer 'Microsoft.Sql/servers@2022-05-01-preview' = {
  name: serverName
  location: location
  properties: {
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
  }
}

resource sqlDB 'Microsoft.Sql/servers/databases@2022-05-01-preview' = {
  parent: sqlServer
  name: sqlDBName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
}
/*
INSTRUCCIONES IMPORTANTES
    Comando para ejecutar el template desde CLI
            az group create --name TEST-RG --location eastus
            az deployment group create --resource-group TEST-RG --template-file createSingleSQLDB.bicep --parameters administratorLogin=<admin-login>
                  Reemplaza <admin-login> por el nombre de usuario del administrador del servidor lógico de SQL.
*/
