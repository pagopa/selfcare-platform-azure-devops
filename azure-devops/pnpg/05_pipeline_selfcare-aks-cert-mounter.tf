variable "selfcare-aks-cert-mounter" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "selfcare-aks-cert-mounter"
      branch_name     = "refs/heads/main"
      pipelines_path  = ".devops"
      yml_prefix_name = "selfcare-pnpg"
    }
    pipeline = {
      enable_code_review = true
      enable_deploy      = true
      path               = "pnpg\\selfcare-aks-cert-mounter"
    }
  }
}

locals {
  # global vars
  selfcare-aks-cert-mounter-variables = {
    dockerfile = "Dockerfile"
  }
  # global secrets
  selfcare-aks-cert-mounter-variables_secret = {

  }
  # code_review vars
  selfcare-aks-cert-mounter-variables_code_review = {
    sonarcloud_service_conn = "SONARCLOUD-SERVICE-CONN"
    sonarcloud_org          = var.selfcare-aks-cert-mounter.repository.organization
    sonarcloud_project_key  = "${var.selfcare-aks-cert-mounter.repository.organization}_${var.selfcare-aks-cert-mounter.repository.name}"
    sonarcloud_project_name = var.selfcare-aks-cert-mounter.repository.name
  }
  # code_review secrets
  selfcare-aks-cert-mounter-variables_secret_code_review = {

  }
  # deploy vars
  selfcare-aks-cert-mounter-variables_deploy = {
    K8S_IMAGE_REPOSITORY_NAME        = replace(var.selfcare-aks-cert-mounter.repository.name, "-", "")
    DEPLOY_NAMESPACE                 = local.domain
    SETTINGS_XML_RW_SECURE_FILE_NAME = "settings-rw.xml"
    SETTINGS_XML_RO_SECURE_FILE_NAME = "settings-ro.xml"
    HELM_RELEASE_NAME                = var.selfcare-aks-cert-mounter.repository.name

    DEV_CONTAINER_REGISTRY_SERVICE_CONN = local.service_endpoint_azure_devops_docker_dev_name
    DEV_KUBERNETES_SERVICE_CONN         = local.srv_endpoint_name_aks_dev
    DEV_CONTAINER_REGISTRY_NAME         = local.aks_dev_docker_registry_name
    DEV_AGENT_POOL                      = local.azdo_agent_pool_dev

    UAT_CONTAINER_REGISTRY_SERVICE_CONN = local.service_endpoint_azure_devops_docker_uat_name
    UAT_KUBERNETES_SERVICE_CONN         = local.srv_endpoint_name_aks_uat
    UAT_CONTAINER_REGISTRY_NAME         = local.aks_uat_docker_registry_name
    UAT_AGENT_POOL                      = local.azdo_agent_pool_uat

    PROD_CONTAINER_REGISTRY_SERVICE_CONN = local.service_endpoint_azure_devops_docker_prod_name
    PROD_KUBERNETES_SERVICE_CONN         = local.srv_endpoint_name_aks_prod
    PROD_CONTAINER_REGISTRY_NAME         = local.aks_prod_docker_registry_name
    PROD_AGENT_POOL                      = local.azdo_agent_pool_prod

  }
  # deploy secrets
  selfcare-aks-cert-mounter-variables_secret_deploy = {

  }
}

module "selfcare-aks-cert-mounter_deploy" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy?ref=v2.6.5"
  count  = var.selfcare-aks-cert-mounter.pipeline.enable_deploy == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.selfcare-aks-cert-mounter.repository
  github_service_connection_id = data.azuredevops_serviceendpoint_github.github_rw.service_endpoint_id
  path                         = var.selfcare-aks-cert-mounter.pipeline.path

  ci_trigger_use_yaml = true

  variables = merge(
    local.selfcare-aks-cert-mounter-variables,
    local.selfcare-aks-cert-mounter-variables_deploy,
  )

  variables_secret = merge(
    local.selfcare-aks-cert-mounter-variables_secret,
    local.selfcare-aks-cert-mounter-variables_secret_deploy,
  )

  service_connection_ids_authorization = [
    data.azuredevops_serviceendpoint_github.github_ro.service_endpoint_id,
    data.azuredevops_serviceendpoint_azurerm.azure_dev.service_endpoint_id,
    local.service_endpoint_azure_devops_docker_dev_id,
    azuredevops_serviceendpoint_kubernetes.aks_dev.id,
    data.azuredevops_serviceendpoint_azurerm.azure_uat.service_endpoint_id,
    local.service_endpoint_azure_devops_docker_uat_id,
    azuredevops_serviceendpoint_kubernetes.aks_uat.id,
    data.azuredevops_serviceendpoint_azurerm.azure_prod.service_endpoint_id,
    local.service_endpoint_azure_devops_docker_prod_id,
    azuredevops_serviceendpoint_kubernetes.aks_prod.id,
  ]
}
