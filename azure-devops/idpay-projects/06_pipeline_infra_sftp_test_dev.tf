variable "infra-sftp-test-dev" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "infra-sftp-test"
      branch_name     = "refs/heads/main"
      pipelines_path  = ".devops"
      yml_prefix_name = null
    }
    pipeline = {
      enable_code_review = false
      enable_deploy      = true
      path               = "cstar-dev"
    }
  }
}

locals {
  # global vars
  infra-sftp-test-dev-variables = {
    dockerfile = "Dockerfile"
  }
  # global secrets
  infra-sftp-test-dev-variables_secret = {

  }
  # code_review vars
  infra-sftp-test-dev-variables_code_review = {

  }
  # code_review secrets
  infra-sftp-test-dev-variables_secret_code_review = {

  }
  # deploy vars
  infra-sftp-test-dev-variables_deploy = {
    TF_ENVIRONMENT                     = "DEV"
    TF_DOCKERREGISTRYSERVICECONNECTION = local.service_endpoint_azure_devops_acr_dev_name
    TF_KUBERNETESSERVICECONNECTION     = local.srv_endpoint_name_aks_dev
    TF_CONTAINERREGISTRY               = local.aks_dev_docker_registry_name
    TF_SELFHOSTEDAGENTPOOL             = local.azdo_agent_pool_dev

    K8S_IMAGE_REPOSITORY_NAME = replace(var.infra-sftp-test-dev.repository.name, "-", "")
    DEPLOY_NAMESPACE          = local.domain
    HELM_RELEASE_NAME         = var.infra-sftp-test-dev.repository.name

    DEV_CONTAINER_REGISTRY_SERVICE_CONN = local.service_endpoint_azure_devops_acr_dev_name
    DEV_KUBERNETES_SERVICE_CONN         = local.srv_endpoint_name_aks_dev
    DEV_CONTAINER_REGISTRY_NAME         = local.aks_dev_docker_registry_name
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
  infra-sftp-test-dev-variables_secret_deploy = {

  }
}

module "infra-sftp-test-dev_code_review" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review?ref=v2.2.0"
  count  = var.infra-sftp-test-dev.pipeline.enable_code_review == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.infra-sftp-test-dev.repository
  github_service_connection_id = local.service_endpoint_io_azure_devops_github_ro_id
  path                         = var.infra-sftp-test-dev.pipeline.path

  pull_request_trigger_use_yaml = true

  variables = merge(
    local.infra-sftp-test-dev-variables,
    local.infra-sftp-test-dev-variables_code_review,
  )

  variables_secret = merge(
    local.infra-sftp-test-dev-variables_secret,
    local.infra-sftp-test-dev-variables_secret_code_review,
  )

  service_connection_ids_authorization = [
    local.service_endpoint_io_azure_devops_github_ro_id,
    local.azuredevops_serviceendpoint_sonarcloud_id,
  ]
}

module "infra-sftp-test-dev_deploy" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy?ref=v2.2.0"
  count  = var.infra-sftp-test-dev.pipeline.enable_deploy == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.infra-sftp-test-dev.repository
  github_service_connection_id = local.service_endpoint_io_azure_devops_github_ro_id
  path                         = var.infra-sftp-test-dev.pipeline.path

  variables = merge(
    local.infra-sftp-test-dev-variables,
    local.infra-sftp-test-dev-variables_deploy,
  )

  variables_secret = merge(
    local.infra-sftp-test-dev-variables_secret,
    local.infra-sftp-test-dev-variables_secret_deploy,
  )

  service_connection_ids_authorization = [
    local.service_endpoint_io_azure_devops_github_ro_id,
    # local.service_endpoint_azure_dev_id,
    local.service_endpoint_azure_devops_acr_dev_id,
    azuredevops_serviceendpoint_kubernetes.aks_dev.id,
  ]

}
