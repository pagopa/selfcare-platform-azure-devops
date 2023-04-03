dev_subscription_name  = "DEV-SELFCARE"
uat_subscription_name  = "UAT-SELFCARE"
prod_subscription_name = "PROD-SELFCARE"

project_name     = "selfcare-platform-app-projects"
project_iac_name = "selfcare-iac-projects"

aks_dev_platform_name  = "selc-d-weu-dev01-aks"
aks_uat_platform_name  = "selc-u-weu-uat01-aks"
aks_prod_platform_name = "selc-p-weu-prod01-aks"

service_endpoint_io_azure_devops_github_ro_name = "io-azure-devops-github-ro"
service_endpoint_io_azure_devops_github_rw_name = "io-azure-devops-github-rw"
service_endpoint_io_azure_devops_github_pr_name = "io-azure-devops-github-pr"

service_endpoint_azure_dev_name  = "DEV-SELFCARE-SERVICE-CONN"
service_endpoint_azure_uat_name  = "UAT-SELFCARE-SERVICE-CONN"
service_endpoint_azure_prod_name = "PROD-SELFCARE-SERVICE-CONN"

terraform_remote_state_core = {
  resource_group_name  = "terraform-state-rg"
  storage_account_name = "tfinfprodselfcare"
  container_name       = "terraform-state"
  key                  = "azdo-selfcare-legacy.terraform.tfstate"
}
