variable "rtd_iac" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "cstar-infrastructure"
      branch_name     = "refs/heads/main"
      pipelines_path  = ".devops"
      yml_prefix_name = "rtd"
    }
    pipeline = {
      enable_code_review   = true
      enable_deploy        = true
      path                 = "rtd-infrastructure"
      pipeline_name_prefix = "rtd-infra"
    }
  }
}

locals {
  # global vars
  rtd_iac_variables = {
    tf_dev01_aks_apiserver_url         = module.rtd_dev_secrets.values["cstar-d-weu-dev01-aks-apiserver-url"].value,
    tf_dev01_aks_azure_devops_sa_cacrt = module.rtd_dev_secrets.values["cstar-d-weu-dev01-aks-azure-devops-sa-cacrt"].value,
    tf_dev01_aks_azure_devops_sa_token = base64decode(module.rtd_dev_secrets.values["cstar-d-weu-dev01-aks-azure-devops-sa-token"].value),
    tf_aks_dev_name                    = var.aks_dev_platform_name
  }
  # global secrets
  rtd_iac_variables_secret = {}

  # code_review vars
  rtd_iac_variables_code_review = {}
  # code_review secrets
  rtd_iac_variables_secret_code_review = {}

  # deploy vars
  rtd_iac_variables_deploy = {}
  # deploy secrets
  rtd_iac_variables_secret_deploy = {}
}

module "rtd_iac_code_review" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review?ref=v2.6.2"
  count  = var.rtd_iac.pipeline.enable_code_review == true ? 1 : 0
  path   = var.rtd_iac.pipeline.path

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.rtd_iac.repository
  github_service_connection_id = azuredevops_serviceendpoint_github.io-azure-devops-github-rw.id

  pipeline_name_prefix = var.rtd_iac.pipeline.pipeline_name_prefix

  pull_request_trigger_use_yaml = true

  variables = merge(
    local.rtd_iac_variables,
    local.rtd_iac_variables_code_review,
  )

  variables_secret = merge(
    local.rtd_iac_variables_secret,
    local.rtd_iac_variables_secret_code_review,
  )

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.io-azure-devops-github-ro.id,
    azuredevops_serviceendpoint_azurerm.DEV-CSTAR.id,
    azuredevops_serviceendpoint_azurerm.UAT-CSTAR.id,
    azuredevops_serviceendpoint_azurerm.PROD-CSTAR.id,
  ]
}

module "rtd_iac_deploy" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy?ref=v2.6.2"
  count  = var.rtd_iac.pipeline.enable_deploy == true ? 1 : 0
  path   = var.rtd_iac.pipeline.path

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.rtd_iac.repository
  github_service_connection_id = azuredevops_serviceendpoint_github.io-azure-devops-github-rw.id

  pipeline_name_prefix = var.rtd_iac.pipeline.pipeline_name_prefix

  ci_trigger_use_yaml = true

  variables = merge(
    local.rtd_iac_variables,
    local.rtd_iac_variables_deploy,
  )

  variables_secret = merge(
    local.rtd_iac_variables_secret,
    local.rtd_iac_variables_secret_deploy,
  )

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.io-azure-devops-github-ro.id,
    azuredevops_serviceendpoint_azurerm.DEV-CSTAR.id,
    azuredevops_serviceendpoint_azurerm.UAT-CSTAR.id,
    azuredevops_serviceendpoint_azurerm.PROD-CSTAR.id,
  ]
}
