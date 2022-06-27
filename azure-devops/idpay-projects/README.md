<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.5 |
| <a name="requirement_azuredevops"></a> [azuredevops](#requirement\_azuredevops) | >= 0.2.1 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.99.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuredevops"></a> [azuredevops](#provider\_azuredevops) | 0.2.1 |
| <a name="provider_azurerm.dev"></a> [azurerm.dev](#provider\_azurerm.dev) | 2.99.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_DEV-CSTAR-IDPAY-TLS-CERT-SERVICE-CONN"></a> [DEV-CSTAR-IDPAY-TLS-CERT-SERVICE-CONN](#module\_DEV-CSTAR-IDPAY-TLS-CERT-SERVICE-CONN) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_serviceendpoint_azurerm_limited | v2.1.0 |
| <a name="module_devops-java-springboot-color_code_review"></a> [devops-java-springboot-color\_code\_review](#module\_devops-java-springboot-color\_code\_review) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review | v2.2.0 |
| <a name="module_devops-java-springboot-color_deploy"></a> [devops-java-springboot-color\_deploy](#module\_devops-java-springboot-color\_deploy) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy | v2.2.0 |
| <a name="module_domain_dev_secrets"></a> [domain\_dev\_secrets](#module\_domain\_dev\_secrets) | git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query | v2.0.4 |
| <a name="module_idpay-fe-welfare_code_review"></a> [idpay-fe-welfare\_code\_review](#module\_idpay-fe-welfare\_code\_review) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review | v2.2.0 |
| <a name="module_idpay-fe-welfare_deploy"></a> [idpay-fe-welfare\_deploy](#module\_idpay-fe-welfare\_deploy) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy | v2.2.0 |
| <a name="module_idpay-onboarding-workflow_code_review"></a> [idpay-onboarding-workflow\_code\_review](#module\_idpay-onboarding-workflow\_code\_review) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review | v2.2.0 |
| <a name="module_idpay-onboarding-workflow_deploy"></a> [idpay-onboarding-workflow\_deploy](#module\_idpay-onboarding-workflow\_deploy) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy | v2.2.0 |
| <a name="module_idpay-reward-calculator_code_review"></a> [idpay-reward-calculator\_code\_review](#module\_idpay-reward-calculator\_code\_review) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review | v2.2.0 |
| <a name="module_idpay-reward-calculator_deploy"></a> [idpay-reward-calculator\_deploy](#module\_idpay-reward-calculator\_deploy) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy | v2.2.0 |
| <a name="module_infra-sftp-test-dev_code_review"></a> [infra-sftp-test-dev\_code\_review](#module\_infra-sftp-test-dev\_code\_review) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review | v2.2.0 |
| <a name="module_infra-sftp-test-dev_deploy"></a> [infra-sftp-test-dev\_deploy](#module\_infra-sftp-test-dev\_deploy) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy | v2.2.0 |
| <a name="module_letsencrypt_dev"></a> [letsencrypt\_dev](#module\_letsencrypt\_dev) | git::https://github.com/pagopa/azurerm.git//letsencrypt_credential | v2.18.0 |
| <a name="module_secret_azdo"></a> [secret\_azdo](#module\_secret\_azdo) | git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query | v2.0.5 |
| <a name="module_tlscert-dev01-idpay-internal-dev-cstar-pagopa-it-cert_az"></a> [tlscert-dev01-idpay-internal-dev-cstar-pagopa-it-cert\_az](#module\_tlscert-dev01-idpay-internal-dev-cstar-pagopa-it-cert\_az) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_tls_cert | v2.1.0 |

## Resources

| Name | Type |
|------|------|
| [azuredevops_serviceendpoint_kubernetes.aks_dev](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_kubernetes) | resource |
| [azurerm_key_vault_access_policy.DEV-CSTAR-IDPAY-TLS-CERT-SERVICE-CONN_kv_access_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azuredevops_project.project](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/project) | data source |
| [azurerm_key_vault.domain_kv_dev](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [terraform_remote_state.core](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dev_subscription_name"></a> [dev\_subscription\_name](#input\_dev\_subscription\_name) | DEV Subscription name | `string` | n/a | yes |
| <a name="input_devops-java-springboot-color"></a> [devops-java-springboot-color](#input\_devops-java-springboot-color) | n/a | `map` | <pre>{<br>  "pipeline": {<br>    "enable_code_review": true,<br>    "enable_deploy": true,<br>    "path": "idpay\\devops-java-springboot-color"<br>  },<br>  "repository": {<br>    "branch_name": "refs/heads/main",<br>    "name": "devops-java-springboot-color",<br>    "organization": "pagopa",<br>    "pipelines_path": ".devops",<br>    "yml_prefix_name": "cstar"<br>  }<br>}</pre> | no |
| <a name="input_idpay-onboarding-workflow"></a> [idpay-onboarding-workflow](#input\_idpay-onboarding-workflow) | n/a | `map` | <pre>{<br>  "pipeline": {<br>    "enable_code_review": true,<br>    "enable_deploy": true,<br>    "path": "idpay\\idpay-onboarding-workflow"<br>  },<br>  "repository": {<br>    "branch_name": "release-dev",<br>    "name": "idpay-onboarding-workflow",<br>    "organization": "pagopa",<br>    "pipelines_path": ".devops",<br>    "yml_prefix_name": null<br>  }<br>}</pre> | no |
| <a name="input_idpay-portal-welfare-frontend"></a> [idpay-portal-welfare-frontend](#input\_idpay-portal-welfare-frontend) | n/a | `map` | <pre>{<br>  "pipeline": {<br>    "enable_code_review": true,<br>    "enable_deploy": true,<br>    "path": "idpay\\idpay-portal-welfare-frontend"<br>  },<br>  "repository": {<br>    "branch_name": "refs/heads/main",<br>    "name": "idpay-portal-welfare-frontend",<br>    "organization": "pagopa",<br>    "path": "idpay\\frontend",<br>    "pipelines_path": ".devops",<br>    "yml_prefix_name": null<br>  }<br>}</pre> | no |
| <a name="input_idpay-reward-calculator"></a> [idpay-reward-calculator](#input\_idpay-reward-calculator) | n/a | `map` | <pre>{<br>  "pipeline": {<br>    "enable_code_review": true,<br>    "enable_deploy": true,<br>    "path": "idpay\\idpay-reward-calculator"<br>  },<br>  "repository": {<br>    "branch_name": "release-dev",<br>    "name": "idpay-reward-calculator",<br>    "organization": "pagopa",<br>    "pipelines_path": ".devops",<br>    "yml_prefix_name": null<br>  }<br>}</pre> | no |
| <a name="input_infra-sftp-test-dev"></a> [infra-sftp-test-dev](#input\_infra-sftp-test-dev) | n/a | `map` | <pre>{<br>  "pipeline": {<br>    "enable_code_review": false,<br>    "enable_deploy": true,<br>    "path": "cstar-dev"<br>  },<br>  "repository": {<br>    "branch_name": "main",<br>    "name": "infra-sftp-test",<br>    "organization": "pagopa",<br>    "pipelines_path": ".devops",<br>    "yml_prefix_name": null<br>  }<br>}</pre> | no |
| <a name="input_prod_subscription_name"></a> [prod\_subscription\_name](#input\_prod\_subscription\_name) | PROD Subscription name | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name (e.g. pagoPA platform) | `string` | n/a | yes |
| <a name="input_terraform_remote_state_core"></a> [terraform\_remote\_state\_core](#input\_terraform\_remote\_state\_core) | n/a | <pre>object({<br>    resource_group_name  = string,<br>    storage_account_name = string,<br>    container_name       = string,<br>    key                  = string<br>  })</pre> | n/a | yes |
| <a name="input_tlscert-dev01-idpay-internal-dev-cstar-pagopa-it"></a> [tlscert-dev01-idpay-internal-dev-cstar-pagopa-it](#input\_tlscert-dev01-idpay-internal-dev-cstar-pagopa-it) | n/a | `map` | <pre>{<br>  "pipeline": {<br>    "dns_record_name": "dev01.idpay.internal",<br>    "dns_zone_name": "dev.cstar.pagopa.it",<br>    "enable_tls_cert": true,<br>    "path": "TLS-Certificates\\DEV",<br>    "variables": {<br>      "CERT_NAME_EXPIRE_SECONDS": "2592000"<br>    },<br>    "variables_secret": {}<br>  },<br>  "repository": {<br>    "branch_name": "master",<br>    "name": "le-azure-acme-tiny",<br>    "organization": "pagopa",<br>    "pipelines_path": "."<br>  }<br>}</pre> | no |
| <a name="input_uat_subscription_name"></a> [uat\_subscription\_name](#input\_uat\_subscription\_name) | UAT Subscription name | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->