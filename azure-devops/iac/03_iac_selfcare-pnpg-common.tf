variable "selfcare_pnpg_common_iac" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "selfcare-infra"
      branch_name     = "refs/heads/main"
      pipelines_path  = ".devops"
      yml_prefix_name = "pnpgcommon"
    }
    pipeline = {
      enable_code_review   = true
      enable_deploy        = true
      path                 = "selfcare-infra"
      pipeline_name_prefix = "pnpgcommon"
    }
  }
}

locals {
  # global vars
  selfcare_pnpg_common_iac_variables = {
    tf_dev_aks_apiserver_url         = module.selfcare_dev_secrets.values["selc-d-weu-dev01-aks-apiserver-url"].value,
    tf_dev_aks_azure_devops_sa_cacrt = module.selfcare_dev_secrets.values["selc-d-weu-dev01-aks-azure-devops-sa-cacrt"].value,
    tf_dev_aks_azure_devops_sa_token = base64decode(module.selfcare_dev_secrets.values["selc-d-weu-dev01-aks-azure-devops-sa-token"].value),
    tf_aks_dev_name                  = var.aks_dev_platform_name
    tf_dev_azure_service_connection  = data.azuredevops_serviceendpoint_azurerm.azure_dev.service_endpoint_name

    tf_uat_aks_apiserver_url         = module.selfcare_uat_secrets.values["selc-u-weu-uat01-aks-apiserver-url"].value,
    tf_uat_aks_azure_devops_sa_cacrt = module.selfcare_uat_secrets.values["selc-u-weu-uat01-aks-azure-devops-sa-cacrt"].value,
    tf_uat_aks_azure_devops_sa_token = base64decode(module.selfcare_uat_secrets.values["selc-u-weu-uat01-aks-azure-devops-sa-token"].value),
    tf_aks_uat_name                  = var.aks_uat_platform_name
    tf_uat_azure_service_connection  = data.azuredevops_serviceendpoint_azurerm.azure_uat.service_endpoint_name

    tf_prod_aks_apiserver_url         = module.selfcare_prod_secrets.values["selc-p-weu-prod01-aks-apiserver-url"].value,
    tf_prod_aks_azure_devops_sa_cacrt = module.selfcare_prod_secrets.values["selc-p-weu-prod01-aks-azure-devops-sa-cacrt"].value,
    tf_prod_aks_azure_devops_sa_token = base64decode(module.selfcare_prod_secrets.values["selc-p-weu-prod01-aks-azure-devops-sa-token"].value),
    tf_aks_prod_name                  = var.aks_prod_platform_name
    tf_prod_azure_service_connection  = data.azuredevops_serviceendpoint_azurerm.azure_prod.service_endpoint_name
  }

  # global secrets
  selfcare_pnpg_common_iac_variables_secret = {}

  # code_review vars
  selfcare_pnpg_common_iac_variables_code_review = {}
  # code_review secrets
  selfcare_pnpg_common_iac_variables_secret_code_review = {}

  # deploy vars
  selfcare_pnpg_common_iac_variables_deploy = {}
  # deploy secrets
  selfcare_pnpg_common_iac_variables_secret_deploy = {}
}

module "selfcare_pnpg_common_iac_code_review" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review?ref=v2.6.2"
  count  = var.selfcare_pnpg_common_iac.pipeline.enable_code_review == true ? 1 : 0
  path   = var.selfcare_pnpg_common_iac.pipeline.path

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.selfcare_pnpg_common_iac.repository
  github_service_connection_id = data.azuredevops_serviceendpoint_github.github_pr.service_endpoint_id

  pipeline_name_prefix = var.selfcare_pnpg_common_iac.pipeline.pipeline_name_prefix

  pull_request_trigger_use_yaml = true

  variables = merge(
    local.selfcare_pnpg_common_iac_variables,
    local.selfcare_pnpg_common_iac_variables_code_review,
  )

  variables_secret = merge(
    local.selfcare_pnpg_common_iac_variables_secret,
    local.selfcare_pnpg_common_iac_variables_secret_code_review,
  )

  service_connection_ids_authorization = [
    data.azuredevops_serviceendpoint_github.github_ro.service_endpoint_id,
    data.azuredevops_serviceendpoint_azurerm.azure_dev.service_endpoint_id,
    data.azuredevops_serviceendpoint_azurerm.azure_uat.service_endpoint_id,
    data.azuredevops_serviceendpoint_azurerm.azure_prod.service_endpoint_id,
  ]
}

module "selfcare_pnpg_common_iac_deploy" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy?ref=v2.6.2"
  count  = var.selfcare_pnpg_common_iac.pipeline.enable_deploy == true ? 1 : 0
  path   = var.selfcare_pnpg_common_iac.pipeline.path

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.selfcare_pnpg_common_iac.repository
  github_service_connection_id = data.azuredevops_serviceendpoint_github.github_pr.service_endpoint_id

  pipeline_name_prefix = var.selfcare_pnpg_common_iac.pipeline.pipeline_name_prefix

  ci_trigger_use_yaml = true

  variables = merge(
    local.selfcare_pnpg_common_iac_variables,
    local.selfcare_pnpg_common_iac_variables_deploy,
  )

  variables_secret = merge(
    local.selfcare_pnpg_common_iac_variables_secret,
    local.selfcare_pnpg_common_iac_variables_secret_deploy,
  )

  service_connection_ids_authorization = [
    data.azuredevops_serviceendpoint_github.github_ro.service_endpoint_id,
    data.azuredevops_serviceendpoint_azurerm.azure_dev.service_endpoint_id,
    data.azuredevops_serviceendpoint_azurerm.azure_uat.service_endpoint_id,
    data.azuredevops_serviceendpoint_azurerm.azure_prod.service_endpoint_id,
  ]
}
