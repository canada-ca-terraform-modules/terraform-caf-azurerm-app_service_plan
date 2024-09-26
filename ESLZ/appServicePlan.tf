variable "AppServicePlan" {
  description = "Object containing all App service plan"
  type = any
  default = {}
}

module "AppServicePlan" {
  source = "github.com/canada-ca-terraform-modules/terraform-caf-azurerm-app_service_plan.git?ref=v1.0.2"
  for_each = var.AppServicePlan

  userDefinedString = each.key
  env = var.env
  group = var.group
  project = var.project
  resource_groups = local.resource_groups_all
  subnets = local.subnets
  ase = local.ase_id
  appServicePlan = each.value
  tags = var.tags
}

locals {
  asp_id = {for name, param in try(var.AppServicePlan, {}): name => module.AppServicePlan[name].asp_id}
}