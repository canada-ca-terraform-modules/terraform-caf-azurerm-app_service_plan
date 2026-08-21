terraform {
  required_version = ">= 1.9"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.0"
    }
  }

  # Empty on purpose: the state file path is supplied at `terraform init`
  # time via `-backend-config="path=..."` (partial configuration), so the
  # target-branch checkout and the PR-branch checkout can point at the same
  # external state file without either owning its own local state.
  backend "local" {}
}

provider "azurerm" {
  storage_use_azuread             = true
  resource_provider_registrations = "legacy"
  features {
    resource_group {
      # This harness's resource group is fully self-owned by Terraform - no
      # risk of destroying anything not created by this run.
      prevent_deletion_if_contains_resources = false
    }
  }
}

module "app_service_plan" {
  # PR code and baseline code are two on-disk checkouts of this same repo,
  # not two resolved git refs - no pinned ?ref, no version toggle here.
  source = "../../"

  env               = var.env
  group             = var.group
  project           = var.project
  userDefinedString = "livetest"
  location          = var.location
  tags              = var.tags

  # resource_group is injected here (not in the tracked tfvars fixture)
  # since it must point at test_dependencies.tf's live, per-PR-suffixed RG.
  appServicePlan = merge(var.appServicePlan, {
    resource_group = azurerm_resource_group.live_test.id
  })
}
