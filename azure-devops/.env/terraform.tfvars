dev_subscription_name  = "DEV-SELFCARE"
uat_subscription_name  = "UAT-SELFCARE"
prod_subscription_name = "PROD-SELFCARE"

project_name     = "selc-platform-app-projects"
project_iac_name = "selc-platform-iac-projects"

aks_dev_platform_name  = "selc-d-weu-dev01-aks"
aks_uat_platform_name  = "selc-u-weu-uat01-aks"
aks_prod_platform_name = "selc-p-weu-prod01-aks"

terraform_remote_state_core = {
  resource_group_name  = "terraform-state-rg"
  storage_account_name = "tfinfprodselfcare"
  container_name       = "terraform-state"
  key                  = "azdo-selfcare-legacy.terraform.tfstate"
}
