locals {
  resource_group_name = strcontains(var.appServicePlan.resource_group, "/resourceGroups/") ? regex("[^\\/]+$", var.appServicePlan.resource_group) : var.resource_groups[var.appServicePlan.resource_group].name

  # If we received an ID for the ASE name, then we take it as is. If not set to null so we can do a data call later
  ase = strcontains(var.appServicePlan.ase.name, "/resourceGroups/") ? var.appServicePlan.ase.name : null
  # Formats the resource group name for the ASE
  ase_rg = strcontains(var.appServicePlan.ase.resource_group, "/resourceGroups/") ? regex("[^\\/]+$", var.appServicePlan.ase.resource_group) : var.resource_groups[var.appServicePlan.ase.resource_group].name
}

