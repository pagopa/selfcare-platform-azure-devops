variable "selfcare-load-tests" {
  default = {
    repository = {
      organization   = "pagopa"
      name           = "selfcare-load-tests"
      branch_name    = "main"
      pipelines_path = "pipelines"
    }
    pipeline = {
      enable_code_review = true
      enable_deploy      = true
      path               = "pnpg\\selfcare-load-tests"
    }
  }
}

module "selfcare-load-tests_run" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_generic?ref=v2.6.5"

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.selfcare-load-tests.repository
  github_service_connection_id = data.azuredevops_serviceendpoint_github.github_pr.service_endpoint_id
  path                         = var.selfcare-load-tests.pipeline.path
  pipeline_name                = "run-load-tests"
  pipeline_yml_filename        = "run-load-tests.yml"
  ci_trigger_use_yaml          = true

  variables        = {
    dev_azure_service_name  = data.azuredevops_serviceendpoint_azurerm.azure_dev.service_endpoint_name
    uat_azure_service_name  = data.azuredevops_serviceendpoint_azurerm.azure_uat.service_endpoint_name
    prod_azure_service_name = data.azuredevops_serviceendpoint_azurerm.azure_prod.service_endpoint_name

    DEV_AGENT_POOL                      = local.azdo_agent_pool_dev
    UAT_AGENT_POOL                      = local.azdo_agent_pool_uat
    PROD_AGENT_POOL                      = local.azdo_agent_pool_prod
  }
  variables_secret = {}

  service_connection_ids_authorization = [
    data.azuredevops_serviceendpoint_github.github_rw.service_endpoint_id,
    data.azuredevops_serviceendpoint_azurerm.azure_dev.service_endpoint_id,
    data.azuredevops_serviceendpoint_azurerm.azure_uat.service_endpoint_id,
    data.azuredevops_serviceendpoint_azurerm.azure_prod.service_endpoint_id
  ]
}
