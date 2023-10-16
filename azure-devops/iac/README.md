<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.5 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >= 2.36.0 |
| <a name="requirement_azuredevops"></a> [azuredevops](#requirement\_azuredevops) | >= 0.4.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.99.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.2.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.9.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuredevops"></a> [azuredevops](#provider\_azuredevops) | 0.4.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_secrets_core_prod"></a> [secrets\_core\_prod](#module\_secrets\_core\_prod) | git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query | v2.0.4 |
| <a name="module_selfcare_dev_secrets"></a> [selfcare\_dev\_secrets](#module\_selfcare\_dev\_secrets) | git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query | v4.13.0 |
| <a name="module_selfcare_legacy_dev_secrets"></a> [selfcare\_legacy\_dev\_secrets](#module\_selfcare\_legacy\_dev\_secrets) | git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query | v4.13.0 |
| <a name="module_selfcare_legacy_iac_code_review"></a> [selfcare\_legacy\_iac\_code\_review](#module\_selfcare\_legacy\_iac\_code\_review) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review | v2.6.2 |
| <a name="module_selfcare_legacy_iac_deploy"></a> [selfcare\_legacy\_iac\_deploy](#module\_selfcare\_legacy\_iac\_deploy) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy | v2.6.2 |
| <a name="module_selfcare_legacy_prod_secrets"></a> [selfcare\_legacy\_prod\_secrets](#module\_selfcare\_legacy\_prod\_secrets) | git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query | v4.13.0 |
| <a name="module_selfcare_legacy_uat_secrets"></a> [selfcare\_legacy\_uat\_secrets](#module\_selfcare\_legacy\_uat\_secrets) | git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query | v4.13.0 |
| <a name="module_selfcare_pnpg_common_iac_code_review"></a> [selfcare\_pnpg\_common\_iac\_code\_review](#module\_selfcare\_pnpg\_common\_iac\_code\_review) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review | v2.6.2 |
| <a name="module_selfcare_pnpg_common_iac_deploy"></a> [selfcare\_pnpg\_common\_iac\_deploy](#module\_selfcare\_pnpg\_common\_iac\_deploy) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy | v2.6.2 |
| <a name="module_selfcare_prod_secrets"></a> [selfcare\_prod\_secrets](#module\_selfcare\_prod\_secrets) | git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query | v4.13.0 |
| <a name="module_selfcare_uat_secrets"></a> [selfcare\_uat\_secrets](#module\_selfcare\_uat\_secrets) | git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query | v4.13.0 |

## Resources

| Name | Type |
|------|------|
| [azuredevops_team.external_team](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/team) | resource |
| [azuredevops_project.project](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/project) | data source |
| [azuredevops_serviceendpoint_azurerm.azure_dev](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/serviceendpoint_azurerm) | data source |
| [azuredevops_serviceendpoint_azurerm.azure_prod](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/serviceendpoint_azurerm) | data source |
| [azuredevops_serviceendpoint_azurerm.azure_uat](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/serviceendpoint_azurerm) | data source |
| [azuredevops_serviceendpoint_github.github_pr](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/serviceendpoint_github) | data source |
| [azuredevops_serviceendpoint_github.github_ro](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/serviceendpoint_github) | data source |
| [terraform_remote_state.core](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aks_dev_platform_name"></a> [aks\_dev\_platform\_name](#input\_aks\_dev\_platform\_name) | AKS DEV platform name | `string` | n/a | yes |
| <a name="input_aks_prod_platform_name"></a> [aks\_prod\_platform\_name](#input\_aks\_prod\_platform\_name) | AKS PROD platform name | `string` | n/a | yes |
| <a name="input_aks_uat_platform_name"></a> [aks\_uat\_platform\_name](#input\_aks\_uat\_platform\_name) | AKS UAT platform name | `string` | n/a | yes |
| <a name="input_dev_subscription_name"></a> [dev\_subscription\_name](#input\_dev\_subscription\_name) | DEV Subscription name | `string` | n/a | yes |
| <a name="input_prod_subscription_name"></a> [prod\_subscription\_name](#input\_prod\_subscription\_name) | PROD Subscription name | `string` | n/a | yes |
| <a name="input_project_iac_name"></a> [project\_iac\_name](#input\_project\_iac\_name) | Project name for IaC projects | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name for IaC projects | `string` | n/a | yes |
| <a name="input_selfcare_legacy_iac"></a> [selfcare\_legacy\_iac](#input\_selfcare\_legacy\_iac) | n/a | `map` | <pre>{<br>  "pipeline": {<br>    "enable_code_review": true,<br>    "enable_deploy": true,<br>    "path": "selfcare-legacy-infra",<br>    "pipeline_name_prefix": ""<br>  },<br>  "repository": {<br>    "branch_name": "refs/heads/main",<br>    "name": "selfcare-infra",<br>    "organization": "pagopa",<br>    "pipelines_path": ".devops",<br>    "yml_prefix_name": "selfcare-infra"<br>  }<br>}</pre> | no |
| <a name="input_selfcare_pnpg_common_iac"></a> [selfcare\_pnpg\_common\_iac](#input\_selfcare\_pnpg\_common\_iac) | n/a | `map` | <pre>{<br>  "pipeline": {<br>    "enable_code_review": true,<br>    "enable_deploy": true,<br>    "path": "selfcare-infra",<br>    "pipeline_name_prefix": "pnpgcommon"<br>  },<br>  "repository": {<br>    "branch_name": "refs/heads/main",<br>    "name": "selfcare-infra",<br>    "organization": "pagopa",<br>    "pipelines_path": ".devops",<br>    "yml_prefix_name": "pnpgcommon"<br>  }<br>}</pre> | no |
| <a name="input_service_endpoint_azure_dev_name"></a> [service\_endpoint\_azure\_dev\_name](#input\_service\_endpoint\_azure\_dev\_name) | n/a | `string` | n/a | yes |
| <a name="input_service_endpoint_azure_prod_name"></a> [service\_endpoint\_azure\_prod\_name](#input\_service\_endpoint\_azure\_prod\_name) | n/a | `string` | n/a | yes |
| <a name="input_service_endpoint_azure_uat_name"></a> [service\_endpoint\_azure\_uat\_name](#input\_service\_endpoint\_azure\_uat\_name) | n/a | `string` | n/a | yes |
| <a name="input_service_endpoint_io_azure_devops_github_pr_name"></a> [service\_endpoint\_io\_azure\_devops\_github\_pr\_name](#input\_service\_endpoint\_io\_azure\_devops\_github\_pr\_name) | n/a | `string` | n/a | yes |
| <a name="input_service_endpoint_io_azure_devops_github_ro_name"></a> [service\_endpoint\_io\_azure\_devops\_github\_ro\_name](#input\_service\_endpoint\_io\_azure\_devops\_github\_ro\_name) | n/a | `string` | n/a | yes |
| <a name="input_service_endpoint_io_azure_devops_github_rw_name"></a> [service\_endpoint\_io\_azure\_devops\_github\_rw\_name](#input\_service\_endpoint\_io\_azure\_devops\_github\_rw\_name) | n/a | `string` | n/a | yes |
| <a name="input_terraform_remote_state_core"></a> [terraform\_remote\_state\_core](#input\_terraform\_remote\_state\_core) | n/a | <pre>object({<br>    resource_group_name  = string,<br>    storage_account_name = string,<br>    container_name       = string,<br>    key                  = string<br>  })</pre> | n/a | yes |
| <a name="input_uat_subscription_name"></a> [uat\_subscription\_name](#input\_uat\_subscription\_name) | UAT Subscription name | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
