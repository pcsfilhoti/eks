terraform {
  backend "azurerm" {
    resource_group_name  = "rgroup-mc1-infra"
    storage_account_name = "storagemc1"
    container_name       = "tfstate"
    key                  = "infra/eks/eks_nonprod_us.tfstate"
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "us-east-1"

}

provider "aws" {
  region = "sa-east-1"
  alias  = "sa-east-1"
}