terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
  backend "azurerm" {
      resource_group_name  = "tfstate"
      storage_account_name = "tfstates9sf1"
      container_name       = "tfstate"
      key                  = "terraform.tfstate"
  }
}   

provider "azurerm" {
  skip_provider_registration = true 
  features {}
}
