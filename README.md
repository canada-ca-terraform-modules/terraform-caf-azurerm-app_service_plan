# terraform-caf-azurerm-app_service_plan

Manages an Azure App Service Plan (`azurerm_service_plan`).

## Providers

| Name    | Version |
| ------- | ------- |
| azurerm | ~> 4.0  |

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
| ase               | Object containing a map of ASE ID to link the App Service Plan                 | `any`         | `null`            |    no    |

## Outputs

| Name                  | Description                                |
| --------------------- | ------------------------------------------ |
| appServicePlan-object | Outputs the entire App Service Plan object |
| asp\_id               | Outputs the ID of the App Service Plan     |
| asp\_name             | Outputs the name of the App Service Plan   |

## TFVARS Parameter

| Name                            | Possible value | Default | Required |
| ------------------------------- | -------------- | ------- | -------- |
| zone\_balancing\_enabled        | true,false     | false   | no       |
| maximum\_elastic\_worker\_count | int            | null    | no       |
| worker\_count                   | int            | 3       | no       |
| per\_site\_scaling\_enabled     | true,false     | false   | no       |
| premium\_plan\_auto\_scale\_enabled | true,false | false   | no       |

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_service_plan.servicePlan](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_appServicePlan"></a> [appServicePlan](#input\_appServicePlan) | Object containing all parameters for the app service Plan | `any` | `{}` | no |
| <a name="input_ase"></a> [ase](#input\_ase) | Object containing a map of ASE ID to link the App Servicce Plan | `any` | `null` | no |
| <a name="input_env"></a> [env](#input\_env) | (Required) Env value for the name of the resource | `string` | n/a | yes |
| <a name="input_group"></a> [group](#input\_group) | (Required) Group value for the name of the resource | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure location for the resource | `string` | `"canadacentral"` | no |
| <a name="input_project"></a> [project](#input\_project) | (Required) Project value for the name of the resource | `string` | n/a | yes |
| <a name="input_resource_groups"></a> [resource\_groups](#input\_resource\_groups) | Resouce group object containing a list of resource group in the target project | `any` | `null` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Subnet object containing a list of subnets in the target project | `any` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Maps of tags that will be applied to the resource | `map(string)` | `{}` | no |
| <a name="input_userDefinedString"></a> [userDefinedString](#input\_userDefinedString) | (Required) UserDefinedString value for the name of the resource | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_appServicePlan-object"></a> [appServicePlan-object](#output\_appServicePlan-object) | Outputs the entire App Service Plan object |
| <a name="output_asp_id"></a> [asp\_id](#output\_asp\_id) | Outputs the ID of the App Service Plan |
| <a name="output_asp_name"></a> [asp\_name](#output\_asp\_name) | Outputs the name of the App Service Plan |
<!-- END_TF_DOCS -->