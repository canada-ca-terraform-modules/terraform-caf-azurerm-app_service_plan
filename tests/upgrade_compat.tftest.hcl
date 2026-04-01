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

# Step 1: simulate currently-deployed resource (pre-upgrade inputs, no new args)
run "baseline_apply" {
  command = apply
  variables {
    appServicePlan = {
      resource_group = "Project"
      os_type        = "Linux"
      sku_name       = "P1v2"
      worker_count   = 3
    }
  }
  assert {
    condition     = azurerm_service_plan.servicePlan.name == "Dev-SLD-test-asp01-asp"
    error_message = "Baseline apply: unexpected resource name"
  }
}

# Step 2: plan upgraded code against that state — no replacement must occur
run "upgrade_plan_no_replacement" {
  command = plan
  variables {
    appServicePlan = {
      resource_group                  = "Project"
      os_type                         = "Linux"
      sku_name                        = "P1v2"
      worker_count                    = 3
      premium_plan_auto_scale_enabled = false
    }
  }
  assert {
    condition     = azurerm_service_plan.servicePlan.name == "Dev-SLD-test-asp01-asp"
    error_message = "Resource name must be unchanged after upgrade"
  }
  assert {
    condition     = azurerm_service_plan.servicePlan.premium_plan_auto_scale_enabled == false
    error_message = "premium_plan_auto_scale_enabled must be false"
  }
}
