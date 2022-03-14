# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
#The Azure Provider can be used to configure infrastructure in 
#Microsoft Azure using the Azure Resource Manager API's. 
#Este es el provider de Azure

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.1"
    }
  }
}



# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
# Manages a Resource Group.
resource "azurerm_resource_group" "rg" {
    name     =  "kubernetes_rg"
    location = var.location

    tags = {
        environment = "CP2"
    }

}

# Storage account
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
#Manages an Azure Storage Account.
resource "azurerm_storage_account" "stAccount" {
    name                     = "staccountcp2pedrogarcia" 
    resource_group_name      = azurerm_resource_group.rg.name
    location                 = azurerm_resource_group.rg.location
    account_tier             = "Standard"
    account_replication_type = "LRS"

# Las tags se utilizan para asociar acciones a objetos
    tags = {
        environment = "CP2"
    }

}