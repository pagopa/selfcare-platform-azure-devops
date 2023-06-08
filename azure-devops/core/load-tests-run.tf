variable "selfcare-load-tests" {
  default = {
    repository = {
      organization   = "pagopa"
      name           = "selfcare-load-tests"
      branch_name    = "main"
      pipelines_path = "pipelines"
    }
  }
}

module "selfcare-load-tests_run" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_generic?ref=v2.6.5"

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.selfcare-load-tests.repository
  github_service_connection_id = azuredevops_serviceendpoint_github.io-azure-devops-github-pr.id
  path                         = "${local.selfcare_legacy.pipelines_folder_name}\\${var.selfcare-load-tests.repository.name}"
  pipeline_name                = "run-load-tests"
  pipeline_yml_filename        = "run-load-tests.yml"
  ci_trigger_use_yaml          = true

  variables        = {
    dev_azure_service_name  = azuredevops_serviceendpoint_azurerm.DEV-SELFCARE.service_endpoint_name
    uat_azure_service_name  = azuredevops_serviceendpoint_azurerm.UAT-SELFCARE.service_endpoint_name
    prod_azure_service_name = azuredevops_serviceendpoint_azurerm.PROD-SELFCARE.service_endpoint_name

    DEV_AGENT_POOL                      = local.azdo_agent_pool_dev
    UAT_AGENT_POOL                      = local.azdo_agent_pool_uat
    PROD_AGENT_POOL                      = local.azdo_agent_pool_prod
  }
  variables_secret = {}

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.io-azure-devops-github-rw.id,
    azuredevops_serviceendpoint_azurerm.DEV-SELFCARE.id,
    azuredevops_serviceendpoint_azurerm.UAT-SELFCARE.id,
    azuredevops_serviceendpoint_azurerm.PROD-SELFCARE.id,
  ]
}
