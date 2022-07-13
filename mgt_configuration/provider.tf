provider "azurerm" {
  features {}
}

terraform {
  required_version = "~> 1.2.3"


  #backend "local" {
  #    path="${var.environment}.terraform.tfstate"
  #}
  
  required_providers {
    azurerm = {
      version = "=3.10.0"
    }
  }
  
  backend "azurerm" {
  }  
}
