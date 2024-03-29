variable "devops-app-status" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "devops-app-status"
      branch_name     = "refs/heads/main"
      pipelines_path  = ".devops"
      yml_prefix_name = "selfcare-ar"
    }
    pipeline = {
      enable_code_review = true
      enable_deploy      = true
      path               = "ar\\devops-app-status"
    }
  }
}

locals {
  # global vars
  devops-app-status-variables = {
    dockerfile = "Dockerfile"
  }
  # global secrets
  devops-app-status-variables_secret = {

  }
  # code_review vars
  devops-app-status-variables_code_review = {
    sonarcloud_service_conn = "SONARCLOUD-SERVICE-CONN"
    sonarcloud_org          = var.devops-app-status.repository.organization
    sonarcloud_project_key  = "${var.devops-app-status.repository.organization}_${var.devops-app-status.repository.name}"
    sonarcloud_project_name = var.devops-app-status.repository.name
  }
  # code_review secrets
  devops-app-status-variables_secret_code_review = {

  }
  # deploy vars
  devops-app-status-variables_deploy = {
    K8S_IMAGE_REPOSITORY_NAME        = replace(var.devops-app-status.repository.name, "-", "")
    DEPLOY_NAMESPACE                 = local.domain
    SETTINGS_XML_RW_SECURE_FILE_NAME = "settings-rw.xml"
    SETTINGS_XML_RO_SECURE_FILE_NAME = "settings-ro.xml"
    HELM_RELEASE_NAME                = var.devops-app-status.repository.name

    DEV_CONTAINER_REGISTRY_SERVICE_CONN = local.service_endpoint_azure_devops_docker_dev_name
    DEV_KUBERNETES_SERVICE_CONN         = local.srv_endpoint_name_aks_dev
    DEV_CONTAINER_REGISTRY_NAME         = local.aks_dev_docker_registry_name
    DEV_AGENT_POOL                      = local.azdo_agent_pool_dev

    # UAT_CONTAINER_REGISTRY_SERVICE_CONN = local.service_endpoint_azure_devops_docker_uat_name
    # UAT_KUBERNETES_SERVICE_CONN         = local.srv_endpoint_name_aks_uat
    # UAT_CONTAINER_REGISTRY_NAME         = local.aks_uat_docker_registry_name
    # UAT_AGENT_POOL                      = local.azdo_agent_pool_uat

    # PROD_CONTAINER_REGISTRY_SERVICE_CONN = local.service_endpoint_azure_devops_docker_prod_name
    # PROD_KUBERNETES_SERVICE_CONN         = local.srv_endpoint_name_aks_prod
    # PROD_CONTAINER_REGISTRY_NAME         = local.aks_prod_docker_registry_name
    # PROD_AGENT_POOL                      = local.azdo_agent_pool_prod

  }
  # deploy secrets
  devops-app-status-variables_secret_deploy = {

  }
}

module "devops-app-status_code_review" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review?ref=v2.6.5"
  count  = var.devops-app-status.pipeline.enable_code_review == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.devops-app-status.repository
  github_service_connection_id = data.azuredevops_serviceendpoint_github.github_rw.service_endpoint_id
  path                         = var.devops-app-status.pipeline.path

  pull_request_trigger_use_yaml = true

  variables = merge(
    local.devops-app-status-variables,
    local.devops-app-status-variables_code_review,
  )

  variables_secret = merge(
    local.devops-app-status-variables_secret,
    local.devops-app-status-variables_secret_code_review,
  )

  service_connection_ids_authorization = [
    data.azuredevops_serviceendpoint_github.github_ro.service_endpoint_id,
    local.azuredevops_serviceendpoint_sonarcloud_id,
  ]
}

module "devops-app-status_deploy" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy?ref=v2.6.5"
  count  = var.devops-app-status.pipeline.enable_deploy == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.devops-app-status.repository
  github_service_connection_id = data.azuredevops_serviceendpoint_github.github_rw.service_endpoint_id
  path                         = var.devops-app-status.pipeline.path

  ci_trigger_use_yaml = true

  variables = merge(
    local.devops-app-status-variables,
    local.devops-app-status-variables_deploy,
  )

  variables_secret = merge(
    local.devops-app-status-variables_secret,
    local.devops-app-status-variables_secret_deploy,
  )

  service_connection_ids_authorization = [
    data.azuredevops_serviceendpoint_github.github_ro.service_endpoint_id,
    data.azuredevops_serviceendpoint_azurerm.azure_dev.service_endpoint_id,
    local.service_endpoint_azure_devops_docker_dev_id,
    ### temp
    # azuredevops_serviceendpoint_kubernetes.aks_dev.id
  ]
}
