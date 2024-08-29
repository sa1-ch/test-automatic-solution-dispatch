terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.76.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.53.1"
    }
    databricks = {
      source  = "databricks/databricks"
      version = "1.20.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.12.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.azure_subscription_id
  tenant_id       = var.azure_tenant_id
}

provider "azurerm" {
  alias = "remote"
  features {}
  //Subscription id of the HUB
  subscription_id = var.azure_core_subscription_id # "DNA-CORE-001"
}

provider "databricks" {
  host = data.azurerm_databricks_workspace.databricks_workspace.workspace_url
}