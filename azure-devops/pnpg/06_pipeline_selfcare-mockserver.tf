variable "selfcare-proxy-mockserver" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "selfcare-proxy-mockserver"
      branch_name     = "refs/heads/main"
      pipelines_path  = ".devops"
      yml_prefix_name = "pnpg"
    }
    pipeline = {
      enable_code_review = false
      enable_deploy      = true
      path               = "pnpg\\selfcare-proxy-mockserver"
    }
  }
}

locals {
  # global vars
  selfcare-proxy-mockserver-variables = {
    docker_base_image_name = "hub.docker.com/r/mockserver/mockserver"
    dockerfile             = "Dockerfile"
  }
  # global secrets
  selfcare-proxy-mockserver-variables_secret = {

  }
  # code_review vars
  selfcare-proxy-mockserver-variables_code_review = {

  }
  # code_review secrets
  selfcare-proxy-mockserver-variables_secret_code_review = {

  }
  # deploy vars
  selfcare-proxy-mockserver-variables_deploy = {
    k8s_image_repository_name = replace(var.selfcare-proxy-mockserver.repository.name, "-", "")
    deployment_name           = "mockserver"
    DEPLOY_NAMESPACE                 = local.domain
    SETTINGS_XML_RW_SECURE_FILE_NAME = "settings-rw.xml"
    SETTINGS_XML_RO_SECURE_FILE_NAME = "settings-ro.xml"
    HELM_RELEASE_NAME                = var.selfcare-proxy-mockserver.repository.name
  }
  # deploy secrets
  selfcare-proxy-mockserver-variables_secret_deploy = {

  }
}

module "selfcare-proxy-mockserver_deploy" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy?ref=v2.6.5"
  count  = var.selfcare-proxy-mockserver.pipeline.enable_deploy == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.selfcare-proxy-mockserver.repository
  github_service_connection_id = data.azuredevops_serviceendpoint_github.github_rw.service_endpoint_id
  path                         = var.selfcare-proxy-mockserver.pipeline.path
  ci_trigger_use_yaml          = true

  variables = merge(
    local.pnpg-be-common-variables_deploy,
    local.selfcare-proxy-mockserver-variables,
    local.selfcare-proxy-mockserver-variables_deploy,
  )

  variables_secret = merge(
    local.selfcare-proxy-mockserver-variables_secret,
    local.selfcare-proxy-mockserver-variables_secret_deploy,
  )

  service_connection_ids_authorization = [
    data.azuredevops_serviceendpoint_github.github_pr.service_endpoint_id,
    data.azuredevops_serviceendpoint_azurerm.azure_dev.service_endpoint_id,
    local.service_endpoint_azure_devops_docker_dev_id,
    azuredevops_serviceendpoint_kubernetes.aks_dev.id
  ]
}
