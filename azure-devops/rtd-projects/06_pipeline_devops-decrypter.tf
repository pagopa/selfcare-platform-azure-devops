variable "rtd-ms-decrypter" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "rtd-ms-decrypter"
      branch_name     = "refs/heads/develop"
      pipelines_path  = ".devops"
      yml_prefix_name = "cstar-rtd"
    }
    pipeline = {
      enable_code_review = true
      enable_deploy      = true
      path               = "rtd\\rtd-ms-decrypter"
    }
  }
}

locals {
  # global vars
  rtd-ms-decrypter-variables = {
    dockerfile = "Dockerfile"
  }
  # global secrets
  rtd-ms-decrypter-variables_secret = {

  }
  # code_review vars
  rtd-ms-decrypter-variables_code_review = {
    sonarcloud_service_conn = "SONARCLOUD-SERVICE-CONN"
    sonarcloud_org          = var.rtd-ms-decrypter.repository.organization
    sonarcloud_project_key  = "${var.rtd-ms-decrypter.repository.organization}_${var.rtd-ms-decrypter.repository.name}"
    sonarcloud_project_name = var.rtd-ms-decrypter.repository.name
  }
  # code_review secrets
  rtd-ms-decrypter-variables_secret_code_review = {

  }
  # deploy vars
  rtd-ms-decrypter-variables_deploy = {
    K8S_IMAGE_REPOSITORY_NAME        = replace(var.rtd-ms-decrypter.repository.name, "-", "")
    DEPLOY_NAMESPACE                 = local.domain
    SETTINGS_XML_RW_SECURE_FILE_NAME = "settings-rw.xml"
    SETTINGS_XML_RO_SECURE_FILE_NAME = "settings-ro.xml"
    HELM_RELEASE_NAME                = var.rtd-ms-decrypter.repository.name

    DEV_CONTAINER_REGISTRY_SERVICE_CONN = local.service_endpoint_azure_devops_docker_dev_name
    DEV_KUBERNETES_SERVICE_CONN         = local.srv_endpoint_name_aks_dev
    DEV_CONTAINER_REGISTRY_NAME         = local.aks_dev_docker_registry_name
    DEV_AGENT_POOL                      = local.azdo_agent_pool_dev

    UAT_CONTAINER_REGISTRY_SERVICE_CONN = local.service_endpoint_azure_devops_docker_uat_name
    UAT_KUBERNETES_SERVICE_CONN         = local.srv_endpoint_name_aks_uat
    UAT_CONTAINER_REGISTRY_NAME         = local.aks_uat_docker_registry_name
    UAT_AGENT_POOL                      = local.azdo_agent_pool_uat

    #    PROD_CONTAINER_REGISTRY_SERVICE_CONN = local.service_endpoint_azure_devops_docker_prod_name
    #    PROD_KUBERNETES_SERVICE_CONN         = local.srv_endpoint_name_aks_prod
    #    PROD_CONTAINER_REGISTRY_NAME         = local.aks_prod_docker_registry_name
    #    PROD_AGENT_POOL                      = local.azdo_agent_pool_prod

  }
  # deploy secrets
  rtd-ms-decrypter-variables_secret_deploy = {

  }
}

module "rtd-ms-decrypter_code_review" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review?ref=v2.2.0"
  count  = var.rtd-ms-decrypter.pipeline.enable_code_review == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.rtd-ms-decrypter.repository
  github_service_connection_id = local.service_endpoint_io_azure_devops_github_pr_id
  path                         = var.rtd-ms-decrypter.pipeline.path

  pull_request_trigger_use_yaml = true

  variables = merge(
    local.rtd-ms-decrypter-variables,
    local.rtd-ms-decrypter-variables_code_review,
  )

  variables_secret = merge(
    local.rtd-ms-decrypter-variables_secret,
    local.rtd-ms-decrypter-variables_secret_code_review,
  )

  service_connection_ids_authorization = [
    local.service_endpoint_io_azure_devops_github_ro_id,
    local.azuredevops_serviceendpoint_sonarcloud_id,
  ]
}

module "rtd-ms-decrypter_deploy" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy?ref=v2.2.0"
  count  = var.rtd-ms-decrypter.pipeline.enable_deploy == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.rtd-ms-decrypter.repository
  github_service_connection_id = local.service_endpoint_io_azure_devops_github_pr_id
  path                         = var.rtd-ms-decrypter.pipeline.path

  ci_trigger_use_yaml = true

  variables = merge(
    local.rtd-ms-decrypter-variables,
    local.rtd-ms-decrypter-variables_deploy,
  )

  variables_secret = merge(
    local.rtd-ms-decrypter-variables_secret,
    local.rtd-ms-decrypter-variables_secret_deploy,
  )

  service_connection_ids_authorization = [
    local.service_endpoint_io_azure_devops_github_pr_id,

    local.service_endpoint_azure_dev_id,
    local.service_endpoint_azure_devops_docker_dev_id,
    azuredevops_serviceendpoint_kubernetes.aks_dev.id,


    local.service_endpoint_azure_uat_id,
    local.service_endpoint_azure_devops_docker_uat_id,
    azuredevops_serviceendpoint_kubernetes.aks_uat.id,

    #    local.service_endpoint_azure_prod_id,
    #    local.service_endpoint_azure_devops_docker_prod_id,
    #    azuredevops_serviceendpoint_kubernetes.aks_prod.id
  ]
}
