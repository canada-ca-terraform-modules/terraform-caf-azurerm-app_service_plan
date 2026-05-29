terraform {
  required_version = ">= 1.9"
}

variable "AppServicePlan" {
  description = "Object containing all App service plan"
  type        = any
  default     = {}
}

module "AppServicePlan" {
  source   = "github.com/canada-ca-terraform-modules/terraform-caf-azurerm-app_service_plan.git?ref=v1.1.0"
  for_each = var.AppServicePlan

  userDefinedString = each.key
  env               = var.env
  group             = var.group
  project           = var.project
  resource_groups   = local.resource_groups_all
  subnets           = local.subnets
  ase               = local.ase_id
  appServicePlan    = each.value
  tags              = var.tags
}

# Example: collect ASP IDs for use in downstream modules (e.g. azurerm_linux_web_app)
locals {
  # tflint-ignore: terraform_unused_declarations
  asp_id = { for name, param in try(var.AppServicePlan, {}) : name => module.AppServicePlan[name].asp_id }
}

