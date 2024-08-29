terraform {
  backend "azurerm" {
    tenant_id            = "2fc13e34-f03f-498b-982a-7cb446e25bc6"
    subscription_id      = "c6bfc6b3-5e5e-45f8-b6b7-2f8f1c8a1a0e"
    resource_group_name  = "ODDA-TFSTATE-DEV-RG"
    storage_account_name = "oddatfstateeus2devsa"
    container_name       = "resource-tfstate"
    key                  = "ODDA1-{solution_resource_name}-EUS2"
  }
}