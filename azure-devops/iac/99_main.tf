terraform {
  required_version = ">= 1.3.5"
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = ">= 0.4.0"
    }
    azurerm = {
      version = ">= 2.99.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.2.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.36.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.9.1"
    }
  }
  backend "azurerm" {}
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
  }
}

provider "azurerm" {
  alias = "dev"
  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
  }
  subscription_id = module.secret_azdo.values["PAGOPAIT-DEV-SELC-SUBSCRIPTION-ID"].value
}

provider "azurerm" {
  alias = "uat"
  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
  }
  subscription_id = module.secret_azdo.values["PAGOPAIT-UAT-SELC-SUBSCRIPTION-ID"].value
}

provider "azurerm" {
  alias = "prod"
  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
  }
  subscription_id = module.secret_azdo.values["PAGOPAIT-PROD-SELC-SUBSCRIPTION-ID"].value
}
