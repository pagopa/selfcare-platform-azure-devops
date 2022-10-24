variable "cstar-aks-cert-mounter" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "cstar-aks-cert-mounter"
      branch_name     = "refs/heads/main"
      pipelines_path  = ".devops"
      yml_prefix_name = "rtd"
    }
    pipeline = {
      enable_code_review = true
      enable_deploy      = true
      path               = "rtd\\cstar-aks-cert-mounter"
    }
  }
}

locals {
  # global vars
  cstar-aks-cert-mounter-variables = {
    dockerfile = "Dockerfile"
  }
  # global secrets
  cstar-aks-cert-mounter-variables_secret = {

  }
  # code_review vars
  cstar-aks-cert-mounter-variables_code_review = {
  }
  # code_review secrets
  cstar-aks-cert-mounter-variables_secret_code_review = {

  }
  # deploy vars
  cstar-aks-cert-mounter-variables_deploy = {
    TF_DEPLOY_NAMESPACE  = local.domain
    TF_DOMAIN            = local.domain
    TF_HELM_RELEASE_NAME = var.cstar-aks-cert-mounter.repository.name

    TF_DEV_KUBERNETES_SERVICE_CONN = local.srv_endpoint_name_aks_dev
    TF_DEV_AGENT_POOL              = local.azdo_agent_pool_dev

    TF_UAT_KUBERNETES_SERVICE_CONN = local.srv_endpoint_name_aks_uat
    TF_UAT_AGENT_POOL              = local.azdo_agent_pool_uat

    TF_PROD_KUBERNETES_SERVICE_CONN = local.srv_endpoint_name_aks_prod
    TF_PROD_AGENT_POOL              = local.azdo_agent_pool_prod

  }
  # deploy secrets
  cstar-aks-cert-mounter-variables_secret_deploy = {

  }
}

module "cstar-aks-cert-mounter_deploy" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy?ref=v2.6.5"
  count  = var.cstar-aks-cert-mounter.pipeline.enable_deploy == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.cstar-aks-cert-mounter.repository
  github_service_connection_id = local.service_endpoint_io_azure_devops_github_pr_id
  path                         = var.cstar-aks-cert-mounter.pipeline.path

  ci_trigger_use_yaml           = true
  pull_request_trigger_use_yaml = true

  variables = merge(
    local.cstar-aks-cert-mounter-variables,
    local.cstar-aks-cert-mounter-variables_deploy,
  )

  variables_secret = merge(
    local.cstar-aks-cert-mounter-variables_secret,
    local.cstar-aks-cert-mounter-variables_secret_deploy,
  )

  service_connection_ids_authorization = [
    local.service_endpoint_io_azure_devops_github_pr_id,

    local.service_endpoint_azure_dev_id,
    local.service_endpoint_azure_devops_docker_dev_id,
    azuredevops_serviceendpoint_kubernetes.aks_dev.id,


    local.service_endpoint_azure_uat_id,
    local.service_endpoint_azure_devops_docker_uat_id,
    azuredevops_serviceendpoint_kubernetes.aks_uat.id,

    local.service_endpoint_azure_prod_id,
    local.service_endpoint_azure_devops_docker_prod_id,
    azuredevops_serviceendpoint_kubernetes.aks_prod.id,
  ]
}
