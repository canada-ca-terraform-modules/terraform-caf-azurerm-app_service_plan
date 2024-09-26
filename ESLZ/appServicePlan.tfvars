AppServicePlan = {
  test = {
    resource_group = "Project"
    os_type = "Linux"
    sku_name = "I1v2"
    ase = "name"
  
    # Optional: Uncomment if you want to set any of these parameters to values other than the defaults below. 
    # zone_balancing_enabled = false
    # maximum_elastic_worker_count = null
    # worker_count = 3
    # per_site_scaling_enabled = false

  }
}