resource "azurerm_service_plan" "servicePlan" {
  name = local.asp-name
  location = var.location
  resource_group_name = local.resource_group_name
  os_type = var.appServicePlan.os_type
  sku_name = var.appServicePlan.sku_name
  app_service_environment_id = local.ase

  # Optional parameters
  maximum_elastic_worker_count = try(var.appServicePlan.maximum_elastic_worker_count, null)
  worker_count = try(var.appServicePlan.worker_count, 3)
  per_site_scaling_enabled = try(var.appServicePlan.per_site_scaling_enabled, false)
  zone_balancing_enabled = try(var.appServicePlan.zone_balancing_enabled, false)

  tags = merge(var.tags, try(var.appServicePlan.tags, {}))

}

# If local.ase is null, then we need to do a data call to find the ID.
# data "azurerm_app_service_environment_v3" "ase" {
#   count = local.ase == null ? 1 : 0
#   name = replace("${var.env}-${var.group}-${var.project}-${var.appServicePlan.ase.name}-ase", "/[//\"'\\[\\]:|<>+=;,?*@&]/", "")
#   resource_group_name = local.ase_rg
# }