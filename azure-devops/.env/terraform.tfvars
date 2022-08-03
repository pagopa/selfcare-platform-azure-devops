dev_subscription_name  = "DEV-CSTAR"
uat_subscription_name  = "UAT-CSTAR"
prod_subscription_name = "PROD-CSTAR"

project_name     = "cstar-platform-app-projects"
project_iac_name = "cstar-platform-iac-projects"

terraform_remote_state_core = {
  resource_group_name  = "io-infra-rg"
  storage_account_name = "cstarinfrastterraform"
  container_name       = "azuredevopsstate"
  key                  = "core-devops.terraform.tfstate"
}
