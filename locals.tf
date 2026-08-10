locals {
  resource_group_name = strcontains(var.appServicePlan.resource_group, "/resourceGroups/") ? regex("[^\\/]+$", var.appServicePlan.resource_group) : var.resource_groups[var.appServicePlan.resource_group].name

  # If we received an ID for the ASE name, then we take it as is. If not set to null so we can do a data call later
  ase = try(var.appServicePlan.ase, "") == "" ? null : strcontains(var.appServicePlan.ase, "/resourceGroups/") ? var.appServicePlan.ase : var.ase[var.appServicePlan.ase]
}

