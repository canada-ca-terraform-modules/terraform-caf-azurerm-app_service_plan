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
