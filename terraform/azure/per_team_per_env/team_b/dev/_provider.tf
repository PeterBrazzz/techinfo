terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
  backend "azurerm" {
      resource_group_name  = "tfstate-team-b"
      storage_account_name = "tfstate0team0b"
      container_name       = "tfstate0team0b0dev"
      key                  = "terraform.tfstate"
  }
}   

provider "azurerm" {
  skip_provider_registration = true 
  features {}
}
