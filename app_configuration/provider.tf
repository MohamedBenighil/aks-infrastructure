provider "azurerm" {
  features {}
}

terraform {
  required_version = "~> 1.2.3"

  required_providers {
    azurerm = {
      version = "=3.10.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "=2.25.0"
    }
  }
  backend "azurerm" {
  }  
}
