terraform {
  required_version = ">= 1.1.5"
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = ">= 0.2.2"
    }
    azurerm = {
      version = ">= 2.99.0"
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
  subscription_id = module.secret_azdo.values["PAGOPAIT-DEV-CSTAR-SUBSCRIPTION-ID"].value
}

provider "azurerm" {
  alias = "uat"
  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
  }
  subscription_id = module.secret_azdo.values["PAGOPAIT-UAT-CSTAR-SUBSCRIPTION-ID"].value
}

provider "azurerm" {
  alias = "prod"
  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
  }
  subscription_id = module.secret_azdo.values["PAGOPAIT-PROD-CSTAR-SUBSCRIPTION-ID"].value
}
