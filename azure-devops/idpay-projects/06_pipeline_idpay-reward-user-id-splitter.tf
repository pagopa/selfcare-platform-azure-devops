variable "idpay-reward-user-id-splitter" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "idpay-reward-user-id-splitter"
      branch_name     = "release-dev"
      pipelines_path  = ".devops"
      yml_prefix_name = null
    }
    pipeline = {
      enable_code_review = true
      enable_deploy      = true
      path               = "idpay\\idpay-reward-user-id-splitter"
    }
  }
}

locals {
  # global vars
  idpay-reward-user-id-splitter-variables = {
    dockerfile = "Dockerfile"
  }
  # global secrets
  idpay-reward-user-id-splitter-variables_secret = {

  }
  # code_review vars
  idpay-reward-user-id-splitter-variables_code_review = {
    sonarcloud_service_conn = "SONARCLOUD-SERVICE-CONN"
    sonarcloud_org          = var.idpay-reward-user-id-splitter.repository.organization
    sonarcloud_project_key  = "${var.idpay-reward-user-id-splitter.repository.organization}_${var.idpay-reward-user-id-splitter.repository.name}"
    sonarcloud_project_name = var.idpay-reward-user-id-splitter.repository.name
  }
  # code_review secrets
  idpay-reward-user-id-splitter-variables_secret_code_review = {

  }
  # deploy vars
  idpay-reward-user-id-splitter-variables_deploy = {
    K8S_IMAGE_REPOSITORY_NAME        = replace(var.idpay-reward-user-id-splitter.repository.name, "-", "")
    DEPLOY_NAMESPACE                 = local.domain
    SETTINGS_XML_RW_SECURE_FILE_NAME = "settings-rw.xml"
    SETTINGS_XML_RO_SECURE_FILE_NAME = "settings-ro.xml"
    HELM_RELEASE_NAME                = var.idpay-reward-user-id-splitter.repository.name

    DEV_CONTAINER_REGISTRY_SERVICE_CONN = local.service_endpoint_azure_devops_acr_aks_dev_name
    DEV_KUBERNETES_SERVICE_CONN         = local.srv_endpoint_name_aks_dev
    DEV_CONTAINER_REGISTRY_NAME         = local.aks_cr_name_dev
    DEV_AGENT_POOL                      = local.azdo_agent_pool_dev
    UAT_CONTAINER_REGISTRY_SERVICE_CONN = local.service_endpoint_azure_devops_acr_aks_uat_name
    UAT_KUBERNETES_SERVICE_CONN         = local.srv_endpoint_name_aks_uat
    UAT_CONTAINER_REGISTRY_NAME         = local.aks_cr_name_uat
    UAT_AGENT_POOL                      = local.azdo_agent_pool_uat
    # PROD_CONTAINER_REGISTRY_SERVICE_CONN = azuredevops_serviceendpoint_azurecr.cstar-azurecr-prod.service_endpoint_name
    # PROD_KUBERNETES_SERVICE_CONN         = azuredevops_serviceendpoint_kubernetes.cstar-aks-prod.service_endpoint_name
    # PROD_CONTAINER_REGISTRY_NAME         = "cstarpacr.azurecr.io"
    # PROD_AGENT_POOL                      = "cstar-prod-linux"
  }
  # deploy secrets
  idpay-reward-user-id-splitter-variables_secret_deploy = {

  }
}

module "idpay-reward-user-id-splitter_code_review" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review?ref=v2.2.0"
  count  = var.idpay-reward-user-id-splitter.pipeline.enable_code_review == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.idpay-reward-user-id-splitter.repository
  github_service_connection_id = local.service_endpoint_io_azure_devops_github_pr_id
  path                         = var.idpay-reward-user-id-splitter.pipeline.path

  pull_request_trigger_use_yaml = true

  variables = merge(
    local.idpay-reward-user-id-splitter-variables,
    local.idpay-reward-user-id-splitter-variables_code_review,
  )

  variables_secret = merge(
    local.idpay-reward-user-id-splitter-variables_secret,
    local.idpay-reward-user-id-splitter-variables_secret_code_review,
  )

  service_connection_ids_authorization = [
    local.service_endpoint_io_azure_devops_github_ro_id,
    local.azuredevops_serviceendpoint_sonarcloud_id,
  ]
}

module "idpay-reward-user-id-splitter_deploy" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy?ref=v2.2.0"
  count  = var.idpay-reward-user-id-splitter.pipeline.enable_deploy == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.idpay-reward-user-id-splitter.repository
  github_service_connection_id = local.service_endpoint_io_azure_devops_github_pr_id
  path                         = var.idpay-reward-user-id-splitter.pipeline.path
  ci_trigger_use_yaml          = true

  variables = merge(
    local.idpay-reward-user-id-splitter-variables,
    local.idpay-reward-user-id-splitter-variables_deploy,
  )

  variables_secret = merge(
    local.idpay-reward-user-id-splitter-variables_secret,
    local.idpay-reward-user-id-splitter-variables_secret_deploy,
  )

  service_connection_ids_authorization = [
    local.service_endpoint_io_azure_devops_github_pr_id,

    local.service_endpoint_azure_dev_id,
    local.service_endpoint_azure_devops_acr_aks_dev_id,
    azuredevops_serviceendpoint_kubernetes.aks_dev.id
  ]

}
