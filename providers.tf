terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

locals {
  instance_name = "${terraform.workspace}"
}

provider "azurerm" {
  features {}
}
