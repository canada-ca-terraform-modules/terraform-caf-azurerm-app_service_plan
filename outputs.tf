output "appServicePlan-object" {
  description = "Outputs the entire App Service Plan object"
  value = azurerm_service_plan.servicePlan
}

output "id" {
  description = "Outputs the ID of the App Service Plan"
  value = azurerm_service_plan.servicePlan.id
}

output "name" {
  description = "Outputs the name of the App Service Plan"
  value = azurerm_service_plan.servicePlan.name
}