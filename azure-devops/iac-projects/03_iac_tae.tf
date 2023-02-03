variable "tae_iac" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "cstar-infrastructure"
      branch_name     = "refs/heads/main"
      pipelines_path  = ".devops"
      yml_prefix_name = "tae"
    }
    pipeline = {
      enable_code_review   = true
      enable_deploy        = true
      path                 = "tae-infrastructure"
      pipeline_name_prefix = "tae-infra"
    }
  }
}

locals {
  # global vars
  tae_iac_variables = {
  }
  # global secrets
  tae_iac_variables_secret = {}

  # code_review vars
  tae_iac_variables_code_review = {}
  # code_review secrets
  tae_iac_variables_secret_code_review = {}

  # deploy vars
  tae_iac_variables_deploy = {}
  # deploy secrets
  tae_iac_variables_secret_deploy = {}
}

module "tae_iac_code_review" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review?ref=v2.6.2"
  count  = var.tae_iac.pipeline.enable_code_review == true ? 1 : 0
  path   = var.tae_iac.pipeline.path

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.tae_iac.repository
  github_service_connection_id = azuredevops_serviceendpoint_github.io-azure-devops-github-rw.id

  pipeline_name_prefix = var.tae_iac.pipeline.pipeline_name_prefix

  pull_request_trigger_use_yaml = true

  variables = merge(
    local.tae_iac_variables,
    local.tae_iac_variables_code_review,
  )

  variables_secret = merge(
    local.tae_iac_variables_secret,
    local.tae_iac_variables_secret_code_review,
  )

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.io-azure-devops-github-ro.id,
    azuredevops_serviceendpoint_azurerm.DEV-CSTAR.id,
    azuredevops_serviceendpoint_azurerm.UAT-CSTAR.id,
    azuredevops_serviceendpoint_azurerm.PROD-CSTAR.id,
  ]
}

module "tae_iac_deploy" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy?ref=v2.6.2"
  count  = var.tae_iac.pipeline.enable_deploy == true ? 1 : 0
  path   = var.tae_iac.pipeline.path

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.tae_iac.repository
  github_service_connection_id = azuredevops_serviceendpoint_github.io-azure-devops-github-rw.id

  pipeline_name_prefix = var.tae_iac.pipeline.pipeline_name_prefix

  ci_trigger_use_yaml = true

  variables = merge(
    local.tae_iac_variables,
    local.tae_iac_variables_deploy,
  )

  variables_secret = merge(
    local.tae_iac_variables_secret,
    local.tae_iac_variables_secret_deploy,
  )

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.io-azure-devops-github-ro.id,
    azuredevops_serviceendpoint_azurerm.DEV-CSTAR.id,
    azuredevops_serviceendpoint_azurerm.UAT-CSTAR.id,
    azuredevops_serviceendpoint_azurerm.PROD-CSTAR.id,
  ]
}
