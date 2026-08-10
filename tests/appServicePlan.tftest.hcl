mock_provider "azurerm" {}

variables {
  env               = "Dev"
  group             = "SLD"
  project           = "test"
  userDefinedString = "asp01"
  resource_groups = {
    Project = {
      name     = "rg-project"
      location = "canadacentral"
    }
  }
}

run "naming_convention" {
  command = plan
  variables {
    appServicePlan = {
      resource_group = "Project"
      os_type        = "Linux"
      sku_name       = "P1v2"
    }
  }
  assert {
    condition     = azurerm_service_plan.servicePlan.name == "Dev-SLD-test-asp01-asp"
    error_message = "Name must follow {env}-{group}-{project}-{userDefinedString}-asp convention"
  }
}

run "default_values" {
  command = plan
  variables {
    appServicePlan = {
      resource_group = "Project"
      os_type        = "Linux"
      sku_name       = "P1v2"
    }
  }
  assert {
    condition     = azurerm_service_plan.servicePlan.worker_count == 3
    error_message = "worker_count must default to 3"
  }
  assert {
    condition     = azurerm_service_plan.servicePlan.per_site_scaling_enabled == false
    error_message = "per_site_scaling_enabled must default to false"
  }
  assert {
    condition     = azurerm_service_plan.servicePlan.zone_balancing_enabled == false
    error_message = "zone_balancing_enabled must default to false"
  }
  assert {
    condition     = azurerm_service_plan.servicePlan.premium_plan_auto_scale_enabled == false
    error_message = "premium_plan_auto_scale_enabled must default to false"
  }
}

run "premium_auto_scale_enabled" {
  command = plan
  variables {
    appServicePlan = {
      resource_group                  = "Project"
      os_type                         = "Linux"
      sku_name                        = "P1v2"
      premium_plan_auto_scale_enabled = true
    }
  }
  assert {
    condition     = azurerm_service_plan.servicePlan.premium_plan_auto_scale_enabled == true
    error_message = "premium_plan_auto_scale_enabled must be settable"
  }
}

run "zone_balancing_with_worker_count" {
  command = plan
  variables {
    appServicePlan = {
      resource_group         = "Project"
      os_type                = "Linux"
      sku_name               = "P1v2"
      zone_balancing_enabled = true
      worker_count           = 3
    }
  }
  assert {
    condition     = azurerm_service_plan.servicePlan.zone_balancing_enabled == true
    error_message = "zone_balancing_enabled must be settable"
  }
}

run "per_site_scaling_enabled" {
  command = plan
  variables {
    appServicePlan = {
      resource_group           = "Project"
      os_type                  = "Linux"
      sku_name                 = "P1v2"
      per_site_scaling_enabled = true
    }
  }
  assert {
    condition     = azurerm_service_plan.servicePlan.per_site_scaling_enabled == true
    error_message = "per_site_scaling_enabled must be settable"
  }
}

run "worker_count_override" {
  command = plan
  variables {
    appServicePlan = {
      resource_group = "Project"
      os_type        = "Linux"
      sku_name       = "P1v2"
      worker_count   = 6
    }
  }
  assert {
    condition     = azurerm_service_plan.servicePlan.worker_count == 6
    error_message = "worker_count must be overridable away from its default of 3"
  }
}

run "resource_group_full_arm_id" {
  command = plan
  variables {
    appServicePlan = {
      resource_group = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-external"
      os_type        = "Linux"
      sku_name       = "P1v2"
    }
  }
  assert {
    condition     = azurerm_service_plan.servicePlan.resource_group_name == "rg-external"
    error_message = "resource_group must accept a full ARM ID and extract the resource group name from it"
  }
}

run "with_ase" {
  command = plan
  variables {
    ase = {
      myase = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Web/hostingEnvironments/myase"
    }
    appServicePlan = {
      resource_group = "Project"
      os_type        = "Linux"
      sku_name       = "I1v2"
      ase            = "myase"
    }
  }
  assert {
    condition     = azurerm_service_plan.servicePlan.app_service_environment_id != null
    error_message = "app_service_environment_id must be set when ase is provided"
  }
}

run "maximum_elastic_worker_count" {
  command = plan
  variables {
    appServicePlan = {
      resource_group               = "Project"
      os_type                      = "Linux"
      sku_name                     = "EP1"
      maximum_elastic_worker_count = 5
    }
  }
  assert {
    condition     = azurerm_service_plan.servicePlan.maximum_elastic_worker_count == 5
    error_message = "maximum_elastic_worker_count must be settable"
  }
}

run "tags_merge" {
  command = plan
  variables {
    tags = { managed_by = "terraform" }
    appServicePlan = {
      resource_group = "Project"
      os_type        = "Linux"
      sku_name       = "P1v2"
      tags           = { app = "myapp" }
    }
  }
  assert {
    condition     = azurerm_service_plan.servicePlan.tags["managed_by"] == "terraform"
    error_message = "Module-level tags must be merged onto the resource"
  }
  assert {
    condition     = azurerm_service_plan.servicePlan.tags["app"] == "myapp"
    error_message = "appServicePlan.tags must be merged onto the resource"
  }
}
