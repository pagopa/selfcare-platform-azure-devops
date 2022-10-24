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
| <a name="provider_azuredevops"></a> [azuredevops](#provider\_azuredevops) | 0.2.2 |
| <a name="provider_azurerm.dev"></a> [azurerm.dev](#provider\_azurerm.dev) | 2.99.0 |
| <a name="provider_azurerm.prod"></a> [azurerm.prod](#provider\_azurerm.prod) | 2.99.0 |
| <a name="provider_azurerm.uat"></a> [azurerm.uat](#provider\_azurerm.uat) | 2.99.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_DEV-CSTAR-RTD-TLS-CERT-SERVICE-CONN"></a> [DEV-CSTAR-RTD-TLS-CERT-SERVICE-CONN](#module\_DEV-CSTAR-RTD-TLS-CERT-SERVICE-CONN) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_serviceendpoint_azurerm_limited | v2.1.0 |
| <a name="module_PROD-CSTAR-RTD-TLS-CERT-SERVICE-CONN"></a> [PROD-CSTAR-RTD-TLS-CERT-SERVICE-CONN](#module\_PROD-CSTAR-RTD-TLS-CERT-SERVICE-CONN) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_serviceendpoint_azurerm_limited | v2.1.0 |
| <a name="module_UAT-CSTAR-RTD-TLS-CERT-SERVICE-CONN"></a> [UAT-CSTAR-RTD-TLS-CERT-SERVICE-CONN](#module\_UAT-CSTAR-RTD-TLS-CERT-SERVICE-CONN) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_serviceendpoint_azurerm_limited | v2.1.0 |
| <a name="module_cstar-aks-cert-mounter_deploy"></a> [cstar-aks-cert-mounter\_deploy](#module\_cstar-aks-cert-mounter\_deploy) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy | v2.6.5 |
| <a name="module_devops-java-springboot-color_code_review"></a> [devops-java-springboot-color\_code\_review](#module\_devops-java-springboot-color\_code\_review) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review | v2.2.0 |
| <a name="module_devops-java-springboot-color_deploy"></a> [devops-java-springboot-color\_deploy](#module\_devops-java-springboot-color\_deploy) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy | v2.2.0 |
| <a name="module_domain_dev_secrets"></a> [domain\_dev\_secrets](#module\_domain\_dev\_secrets) | git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query | v2.18.9 |
| <a name="module_domain_prod_secrets"></a> [domain\_prod\_secrets](#module\_domain\_prod\_secrets) | git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query | v2.18.9 |
| <a name="module_domain_uat_secrets"></a> [domain\_uat\_secrets](#module\_domain\_uat\_secrets) | git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query | v2.18.9 |
| <a name="module_letsencrypt_dev"></a> [letsencrypt\_dev](#module\_letsencrypt\_dev) | git::https://github.com/pagopa/azurerm.git//letsencrypt_credential | v3.2.1 |
| <a name="module_letsencrypt_prod"></a> [letsencrypt\_prod](#module\_letsencrypt\_prod) | git::https://github.com/pagopa/azurerm.git//letsencrypt_credential | v3.2.1 |
| <a name="module_letsencrypt_uat"></a> [letsencrypt\_uat](#module\_letsencrypt\_uat) | git::https://github.com/pagopa/azurerm.git//letsencrypt_credential | v3.2.1 |
| <a name="module_secret_azdo"></a> [secret\_azdo](#module\_secret\_azdo) | git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query | v2.19.0 |
| <a name="module_tlscert-dev01-rtd-internal-dev-cstar-pagopa-it-cert_az"></a> [tlscert-dev01-rtd-internal-dev-cstar-pagopa-it-cert\_az](#module\_tlscert-dev01-rtd-internal-dev-cstar-pagopa-it-cert\_az) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_tls_cert | v2.6.5 |
| <a name="module_tlscert-prod01-rtd-internal-cstar-pagopa-it-cert_az"></a> [tlscert-prod01-rtd-internal-cstar-pagopa-it-cert\_az](#module\_tlscert-prod01-rtd-internal-cstar-pagopa-it-cert\_az) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_tls_cert | v2.6.5 |
| <a name="module_tlscert-uat01-rtd-internal-uat-cstar-pagopa-it-cert_az"></a> [tlscert-uat01-rtd-internal-uat-cstar-pagopa-it-cert\_az](#module\_tlscert-uat01-rtd-internal-uat-cstar-pagopa-it-cert\_az) | git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_tls_cert | v2.6.5 |

## Resources

| Name | Type |
|------|------|
| [azuredevops_serviceendpoint_kubernetes.aks_dev](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_kubernetes) | resource |
| [azuredevops_serviceendpoint_kubernetes.aks_prod](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_kubernetes) | resource |
| [azuredevops_serviceendpoint_kubernetes.aks_uat](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_kubernetes) | resource |
| [azurerm_key_vault_access_policy.DEV-CSTAR-RTD-TLS-CERT-SERVICE-CONN_kv_access_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.PROD-CSTAR-RTD-TLS-CERT-SERVICE-CONN_kv_access_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.UAT-CSTAR-RTD-TLS-CERT-SERVICE-CONN_kv_access_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azuredevops_project.project](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/project) | data source |
| [azurerm_key_vault.domain_kv_dev](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault.domain_kv_prod](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault.domain_kv_uat](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [terraform_remote_state.core](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cstar-aks-cert-mounter"></a> [cstar-aks-cert-mounter](#input\_cstar-aks-cert-mounter) | n/a | `map` | <pre>{<br>  "pipeline": {<br>    "enable_code_review": true,<br>    "enable_deploy": true,<br>    "path": "rtd\\cstar-aks-cert-mounter"<br>  },<br>  "repository": {<br>    "branch_name": "refs/heads/main",<br>    "name": "cstar-aks-cert-mounter",<br>    "organization": "pagopa",<br>    "pipelines_path": ".devops",<br>    "yml_prefix_name": "rtd"<br>  }<br>}</pre> | no |
| <a name="input_dev_subscription_name"></a> [dev\_subscription\_name](#input\_dev\_subscription\_name) | DEV Subscription name | `string` | n/a | yes |
| <a name="input_devops-java-springboot-color"></a> [devops-java-springboot-color](#input\_devops-java-springboot-color) | n/a | `map` | <pre>{<br>  "pipeline": {<br>    "enable_code_review": true,<br>    "enable_deploy": true,<br>    "path": "rtd\\devops-java-springboot-color"<br>  },<br>  "repository": {<br>    "branch_name": "refs/heads/main",<br>    "name": "devops-java-springboot-color",<br>    "organization": "pagopa",<br>    "pipelines_path": ".devops",<br>    "yml_prefix_name": "cstar-rtd"<br>  }<br>}</pre> | no |
| <a name="input_prod_subscription_name"></a> [prod\_subscription\_name](#input\_prod\_subscription\_name) | PROD Subscription name | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name (e.g. pagoPA platform) | `string` | n/a | yes |
| <a name="input_terraform_remote_state_core"></a> [terraform\_remote\_state\_core](#input\_terraform\_remote\_state\_core) | n/a | <pre>object({<br>    resource_group_name  = string,<br>    storage_account_name = string,<br>    container_name       = string,<br>    key                  = string<br>  })</pre> | n/a | yes |
| <a name="input_tlscert-dev01-rtd-internal-dev-cstar-pagopa-it"></a> [tlscert-dev01-rtd-internal-dev-cstar-pagopa-it](#input\_tlscert-dev01-rtd-internal-dev-cstar-pagopa-it) | n/a | `map` | <pre>{<br>  "pipeline": {<br>    "dns_record_name": "dev01.rtd.internal",<br>    "dns_zone_name": "dev.cstar.pagopa.it",<br>    "enable_tls_cert": true,<br>    "path": "TLS-Certificates\\DEV",<br>    "variables": {<br>      "CERT_NAME_EXPIRE_SECONDS": "2592000"<br>    },<br>    "variables_secret": {}<br>  },<br>  "repository": {<br>    "branch_name": "refs/heads/master",<br>    "name": "le-azure-acme-tiny",<br>    "organization": "pagopa",<br>    "pipelines_path": "."<br>  }<br>}</pre> | no |
| <a name="input_tlscert-prod01-rtd-internal-cstar-pagopa-it"></a> [tlscert-prod01-rtd-internal-cstar-pagopa-it](#input\_tlscert-prod01-rtd-internal-cstar-pagopa-it) | n/a | `map` | <pre>{<br>  "pipeline": {<br>    "dns_record_name": "prod01.rtd.internal",<br>    "dns_zone_name": "cstar.pagopa.it",<br>    "enable_tls_cert": true,<br>    "path": "TLS-Certificates\\PROD",<br>    "variables": {<br>      "CERT_NAME_EXPIRE_SECONDS": "2592000"<br>    },<br>    "variables_secret": {}<br>  },<br>  "repository": {<br>    "branch_name": "refs/heads/master",<br>    "name": "le-azure-acme-tiny",<br>    "organization": "pagopa",<br>    "pipelines_path": "."<br>  }<br>}</pre> | no |
| <a name="input_tlscert-uat01-rtd-internal-uat-cstar-pagopa-it"></a> [tlscert-uat01-rtd-internal-uat-cstar-pagopa-it](#input\_tlscert-uat01-rtd-internal-uat-cstar-pagopa-it) | n/a | `map` | <pre>{<br>  "pipeline": {<br>    "dns_record_name": "uat01.rtd.internal",<br>    "dns_zone_name": "uat.cstar.pagopa.it",<br>    "enable_tls_cert": true,<br>    "path": "TLS-Certificates\\UAT",<br>    "variables": {<br>      "CERT_NAME_EXPIRE_SECONDS": "2592000"<br>    },<br>    "variables_secret": {}<br>  },<br>  "repository": {<br>    "branch_name": "refs/heads/master",<br>    "name": "le-azure-acme-tiny",<br>    "organization": "pagopa",<br>    "pipelines_path": "."<br>  }<br>}</pre> | no |
| <a name="input_uat_subscription_name"></a> [uat\_subscription\_name](#input\_uat\_subscription\_name) | UAT Subscription name | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
