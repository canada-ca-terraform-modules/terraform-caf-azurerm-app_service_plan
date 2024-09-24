## Providers

| Name    | Version |
| ------- | ------- |
| azurerm | 4.0.0   |

## Inputs

| Name              | Description                                                                    | Type          | Default           | Required |
| ----------------- | ------------------------------------------------------------------------------ | ------------- | ----------------- | :------: |
| appServicePlan    | Object containing all parameters for the app service Plan                      | `any`         | `{}`              |    no    |
| env               | (Required) Env value for the name of the resource                              | `string`      | n/a               |   yes    |
| group             | (Required) Group value for the name of the resource                            | `string`      | n/a               |   yes    |
| location          | Azure location for the resource                                                | `string`      | `"canadacentral"` |    no    |
| project           | (Required) Project value for the name of the resource                          | `string`      | n/a               |   yes    |
| resource\_groups  | Resouce group object containing a list of resource group in the target project | `any`         | `null`            |    no    |
| subnets           | Subnet object containing a list of subnets in the target project               | `any`         | `null`            |    no    |
| tags              | Maps of tags that will be applied to the resource                              | `map(string)` | `{}`              |    no    |
| userDefinedString | (Required) UserDefinedString value for the name of the resource                | `string`      | n/a               |   yes    |

## Outputs

| Name                  | Description                                |
| --------------------- | ------------------------------------------ |
| appServicePlan-object | Outputs the entire App Service Plan object |
| id                    | Outputs the ID of the App Service Plan     |
| name                  | Outputs the name of the App Service Plan   |

## TFVARS Parameter

| Name                         | Possible value | Default | Required |
| ---------------------------- | -------------- | ------- | -------- |
| zone_balancing_enabled       | true,false     | true    | no       |
| maximum_elastic_worker_count | int            | null    | no       |
| worker_count                 | int            | 2       | no       |
| per_site_scaling_enabled     | true,false     | false   | no       |