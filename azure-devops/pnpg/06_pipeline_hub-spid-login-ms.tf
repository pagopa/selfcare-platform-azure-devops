variable "hub-spid-login-ms" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "hub-spid-login-ms"
      branch_name     = "refs/heads/master"
      pipelines_path  = ".devops/kubernetes"
      yml_prefix_name = null
    }
    pipeline = {
      enable_deploy = true
      path          = "pnpg\\hub-spid-login-ms"
    }
  }
}

locals {
  # global vars
  hub-spid-login-ms-variables = {
    dockerfile = "Dockerfile"
  }
  # global secrets
  hub-spid-login-ms-variables_secret = {

  }
  # code_review vars
  hub-spid-login-ms-variables_code_review = {

  }
  # code_review secrets
  hub-spid-login-ms-variables_secret_code_review = {

  }
  # deploy vars
  hub-spid-login-ms-variables_deploy = {
    k8s_image_repository_name = replace(var.hub-spid-login-ms.repository.name, "-", "")

    deploy_namespace = local.domain
    dev_replicas     = 1
    uat_replicas     = 1
    prod_replicas    = 2
  }
  # deploy secrets
  hub-spid-login-ms-variables_secret_deploy = {

  }
}

module "hub-spid-login-ms_deploy" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy?ref=v2.6.5"
  count  = var.hub-spid-login-ms.pipeline.enable_deploy == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.hub-spid-login-ms.repository
  github_service_connection_id = data.azuredevops_serviceendpoint_github.github_rw.service_endpoint_id
  path                         = var.hub-spid-login-ms.pipeline.path
  ci_trigger_use_yaml          = true

  variables = merge(
    local.pnpg-be-common-variables_deploy,
    local.hub-spid-login-ms-variables,
    local.hub-spid-login-ms-variables_deploy,
  )

  variables_secret = merge(
    local.hub-spid-login-ms-variables_secret,
    local.hub-spid-login-ms-variables_secret_deploy,
  )

  service_connection_ids_authorization = [
    data.azuredevops_serviceendpoint_github.github_rw.service_endpoint_id,
    data.azuredevops_serviceendpoint_azurerm.azure_dev.service_endpoint_id,
    local.service_endpoint_azure_devops_docker_dev_id,
    azuredevops_serviceendpoint_kubernetes.aks_dev.id,
    data.azuredevops_serviceendpoint_azurerm.azure_uat.service_endpoint_id,
    local.service_endpoint_azure_devops_docker_uat_id,
    azuredevops_serviceendpoint_kubernetes.aks_uat.id,
    data.azuredevops_serviceendpoint_azurerm.azure_prod.service_endpoint_id,
    local.service_endpoint_azure_devops_docker_prod_id,
    azuredevops_serviceendpoint_kubernetes.aks_prod.id
  ]
}
