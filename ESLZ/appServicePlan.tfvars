AppServicePlan = {
  test = {
    resource_group = "Project"
    os_type = "Linux"
    sku_name = "I2v2"

    # Required blocks, this must be the info related to the APP Service Environment that the plan will be hosted in. Name and resource group can also be IDs
    ase = {
      name = "test"
      resource_group = "Project"
    }

    # Optional: Uncomment if you want to set any of these parameters to values other than the defaults below. 
    # zone_balancing_enabled = false
    # maximum_elastic_worker_count = null
    # worker_count = 2
    # per_site_scaling_enabled = false

  }
}