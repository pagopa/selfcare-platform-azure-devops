<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.5 |
| <a name="requirement_azuredevops"></a> [azuredevops](#requirement\_azuredevops) | >= 0.2.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.99.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuredevops"></a> [azuredevops](#provider\_azuredevops) | 0.2.2 |
| <a name="provider_azurerm.dev"></a> [azurerm.dev](#provider\_azurerm.dev) | 2.99.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_DEV-APPINSIGHTS-SERVICE-CONN"></a> [DEV-APPINSIGHTS-SERVICE-CONN](#module\_DEV-APPINSIGHTS-SERVICE-CONN) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_serviceendpoint_azurerm_limited | v2.6.5 |
| <a name="module_secret_azdo"></a> [secret\_azdo](#module\_secret\_azdo) | git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query | v2.0.5 |

## Resources

| Name | Type |
|------|------|
| [azuredevops_serviceendpoint_azurecr.cstar-azurecrcommon-dev](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_azurecr) | resource |
| [azuredevops_serviceendpoint_azurecr.cstar-azurecrcommon-prod](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_azurecr) | resource |
| [azuredevops_serviceendpoint_azurecr.cstar-azurecrcommon-uat](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_azurecr) | resource |
| [azuredevops_serviceendpoint_azurerm.DEV-CSTAR](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_azurerm) | resource |
| [azuredevops_serviceendpoint_azurerm.PROD-CSTAR](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_azurerm) | resource |
| [azuredevops_serviceendpoint_azurerm.UAT-CSTAR](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_azurerm) | resource |
| [azuredevops_serviceendpoint_github.io-azure-devops-github-pr](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_github) | resource |
| [azuredevops_serviceendpoint_github.io-azure-devops-github-ro](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_github) | resource |
| [azuredevops_serviceendpoint_github.io-azure-devops-github-rw](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_github) | resource |
| [azuredevops_team.external_team](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/team) | resource |
| [azurerm_role_assignment.appinsights_component_contributor_dev](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azuredevops_project.project](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/project) | data source |
| [azurerm_application_insights.application_insights_dev](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/application_insights) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dev_subscription_name"></a> [dev\_subscription\_name](#input\_dev\_subscription\_name) | DEV Subscription name | `string` | n/a | yes |
| <a name="input_prod_subscription_name"></a> [prod\_subscription\_name](#input\_prod\_subscription\_name) | PROD Subscription name | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name project | `string` | n/a | yes |
| <a name="input_uat_subscription_name"></a> [uat\_subscription\_name](#input\_uat\_subscription\_name) | UAT Subscription name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_service_endpoint_azure_dev_id"></a> [service\_endpoint\_azure\_dev\_id](#output\_service\_endpoint\_azure\_dev\_id) | Azure |
| <a name="output_service_endpoint_azure_devops_docker_dev_id"></a> [service\_endpoint\_azure\_devops\_docker\_dev\_id](#output\_service\_endpoint\_azure\_devops\_docker\_dev\_id) | n/a |
| <a name="output_service_endpoint_azure_devops_docker_dev_name"></a> [service\_endpoint\_azure\_devops\_docker\_dev\_name](#output\_service\_endpoint\_azure\_devops\_docker\_dev\_name) | Docker registry |
| <a name="output_service_endpoint_azure_devops_docker_prod_id"></a> [service\_endpoint\_azure\_devops\_docker\_prod\_id](#output\_service\_endpoint\_azure\_devops\_docker\_prod\_id) | n/a |
| <a name="output_service_endpoint_azure_devops_docker_prod_name"></a> [service\_endpoint\_azure\_devops\_docker\_prod\_name](#output\_service\_endpoint\_azure\_devops\_docker\_prod\_name) | n/a |
| <a name="output_service_endpoint_azure_devops_docker_uat_id"></a> [service\_endpoint\_azure\_devops\_docker\_uat\_id](#output\_service\_endpoint\_azure\_devops\_docker\_uat\_id) | n/a |
| <a name="output_service_endpoint_azure_devops_docker_uat_name"></a> [service\_endpoint\_azure\_devops\_docker\_uat\_name](#output\_service\_endpoint\_azure\_devops\_docker\_uat\_name) | n/a |
| <a name="output_service_endpoint_azure_devops_github_pr_name"></a> [service\_endpoint\_azure\_devops\_github\_pr\_name](#output\_service\_endpoint\_azure\_devops\_github\_pr\_name) | n/a |
| <a name="output_service_endpoint_azure_prod_id"></a> [service\_endpoint\_azure\_prod\_id](#output\_service\_endpoint\_azure\_prod\_id) | n/a |
| <a name="output_service_endpoint_azure_uat_id"></a> [service\_endpoint\_azure\_uat\_id](#output\_service\_endpoint\_azure\_uat\_id) | n/a |
| <a name="output_service_endpoint_io_azure_devops_github_pr_id"></a> [service\_endpoint\_io\_azure\_devops\_github\_pr\_id](#output\_service\_endpoint\_io\_azure\_devops\_github\_pr\_id) | Github |
| <a name="output_service_endpoint_io_azure_devops_github_ro_id"></a> [service\_endpoint\_io\_azure\_devops\_github\_ro\_id](#output\_service\_endpoint\_io\_azure\_devops\_github\_ro\_id) | n/a |
| <a name="output_service_endpoint_io_azure_devops_github_ro_name"></a> [service\_endpoint\_io\_azure\_devops\_github\_ro\_name](#output\_service\_endpoint\_io\_azure\_devops\_github\_ro\_name) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
