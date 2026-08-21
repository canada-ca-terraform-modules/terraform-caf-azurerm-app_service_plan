# config/app_service_plan.tfvars
# Tracked, ready-to-run fixture for the test/live harness - one representative
# real-usage instance, not a two-code-path engineered fixture and not a
# dormant "_" template.
#
# resource_group is deliberately absent here - main.tf injects it from
# test_dependencies.tf's live, per-PR-suffixed resource group.

env     = "livetest"
group   = "livetest"
project = "livetest"

appServicePlan = {
  os_type  = "Linux"
  sku_name = "B1"
}
