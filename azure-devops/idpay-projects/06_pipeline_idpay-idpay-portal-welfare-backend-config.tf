variable "idpay-portal-welfare-backend-config" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "idpay-portal-welfare-backend-config"
      branch_name     = "release-dev"
      pipelines_path  = ".devops"
      yml_prefix_name = null
    }
    pipeline = {
      enable_code_review = true
      enable_deploy      = true
      path               = "idpay\\idpay-portal-welfare-backend-config"
    }
  }
}

locals {
  # global vars
  idpay-portal-welfare-backend-config-variables = {
    dockerfile = "Dockerfile"
  }
  # global secrets
  idpay-portal-welfare-backend-config-variables_secret = {

  }
  # code_review vars
  idpay-portal-welfare-backend-config-variables_code_review = {
    sonarcloud_service_conn = "SONARCLOUD-SERVICE-CONN"
    sonarcloud_org          = var.idpay-portal-welfare-backend-config.repository.organization
    sonarcloud_project_key  = "${var.idpay-portal-welfare-backend-config.repository.organization}_${var.idpay-portal-welfare-backend-config.repository.name}"
    sonarcloud_project_name = var.idpay-portal-welfare-backend-config.repository.name
  }
  # code_review secrets
  idpay-portal-welfare-backend-config-variables_secret_code_review = {

  }
  # deploy vars
  idpay-portal-welfare-backend-config-variables_deploy = {
    K8S_IMAGE_REPOSITORY_NAME        = replace(var.idpay-portal-welfare-backend-config.repository.name, "-", "")
    DEPLOY_NAMESPACE                 = local.domain
    SETTINGS_XML_RW_SECURE_FILE_NAME = "settings-rw.xml"
    SETTINGS_XML_RO_SECURE_FILE_NAME = "settings-ro.xml"
    HELM_RELEASE_NAME                = var.idpay-portal-welfare-backend-config.repository.name

    DEV_CONTAINER_REGISTRY_SERVICE_CONN = local.service_endpoint_azure_devops_acr_aks_dev_name
    DEV_KUBERNETES_SERVICE_CONN         = local.srv_endpoint_name_aks_dev
    DEV_CONTAINER_REGISTRY_NAME         = local.aks_cr_name_dev
    DEV_AGENT_POOL                      = local.azdo_agent_pool_dev
    # UAT_CONTAINER_REGISTRY_SERVICE_CONN  = azuredevops_serviceendpoint_azurecr.cstar-azurecr-uat.service_endpoint_name
    # UAT_KUBERNETES_SERVICE_CONN          = azuredevops_serviceendpoint_kubernetes.cstar-aks-uat.service_endpoint_name
    # UAT_CONTAINER_REGISTRY_NAME          = "cstaruacr.azurecr.io"
    # UAT_AGENT_POOL                       = "cstar-uat-linux"
    # PROD_CONTAINER_REGISTRY_SERVICE_CONN = azuredevops_serviceendpoint_azurecr.cstar-azurecr-prod.service_endpoint_name
    # PROD_KUBERNETES_SERVICE_CONN         = azuredevops_serviceendpoint_kubernetes.cstar-aks-prod.service_endpoint_name
    # PROD_CONTAINER_REGISTRY_NAME         = "cstarpacr.azurecr.io"
    # PROD_AGENT_POOL                      = "cstar-prod-linux"
  }
  # deploy secrets
  idpay-portal-welfare-backend-config-variables_secret_deploy = {

  }
}

module "idpay-portal-welfare-backend-config_code_review" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review?ref=v2.2.0"
  count  = var.idpay-portal-welfare-backend-config.pipeline.enable_code_review == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.idpay-portal-welfare-backend-config.repository
  github_service_connection_id = local.service_endpoint_io_azure_devops_github_pr_id
  path                         = var.idpay-portal-welfare-backend-config.pipeline.path

  pull_request_trigger_use_yaml = true

  variables = merge(
    local.idpay-portal-welfare-backend-config-variables,
    local.idpay-portal-welfare-backend-config-variables_code_review,
  )

  variables_secret = merge(
    local.idpay-portal-welfare-backend-config-variables_secret,
    local.idpay-portal-welfare-backend-config-variables_secret_code_review,
  )

  service_connection_ids_authorization = [
    local.service_endpoint_io_azure_devops_github_ro_id,
    local.azuredevops_serviceendpoint_sonarcloud_id,
  ]
}

module "idpay-portal-welfare-backend-config_deploy" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy?ref=v2.2.0"
  count  = var.idpay-portal-welfare-backend-config.pipeline.enable_deploy == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.idpay-portal-welfare-backend-config.repository
  github_service_connection_id = local.service_endpoint_io_azure_devops_github_pr_id
  path                         = var.idpay-portal-welfare-backend-config.pipeline.path
  ci_trigger_use_yaml          = true

  variables = merge(
    local.idpay-portal-welfare-backend-config-variables,
    local.idpay-portal-welfare-backend-config-variables_deploy,
  )

  variables_secret = merge(
    local.idpay-portal-welfare-backend-config-variables_secret,
    local.idpay-portal-welfare-backend-config-variables_secret_deploy,
  )

  service_connection_ids_authorization = [
    local.service_endpoint_io_azure_devops_github_pr_id,

    local.service_endpoint_azure_dev_id,
    local.service_endpoint_azure_devops_acr_aks_dev_id,
    azuredevops_serviceendpoint_kubernetes.aks_dev.id
  ]

}
