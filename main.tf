/* Date updated: 4/3/2024*/

terraform {
  backend "azurerm" {}
}
provider "azurerm" {
    subscription_id = ""
    features {}
    skip_provider_registration = "true  "
}

locals {
  dev-prefix = "dev"
  prod-prefix = "prod"
}

module "devops-networking"{
    source = "git:https://gangadharans@dev.azure.com/gangadharans/sgmsdn_infra_automation/_git/tf-modules//vnet-subnet?ref=v0.1"
    //vnet-name = "devops-vnet"
    resource-group-name = "devops-rg"
    vnet-name = "vnet-hub01-shared01-eu-vy"
    vnet-resource-group-name = "devops-rg"
    vnet-address-space = "10.216.0.0/16"
    //subnet-name = "devops-subnet"
    //subnet-address-prefix = "10.0.0.0/24"
    subnets = {
            "snet-devops01-10.216.80.0_24" = {
            "address_prefixes" = ["10.216.80.0/24"]
        }
        //Subnet for DevOps Dev Apps
            "snet-devappsrv-10.216.100.0_24" = {
            "address_prefixes" = ["10.216.100.0/24"]
        }
        //Subnet for DevOps Dev DB
            "snet-devdatabase-10.216.110.0_24" = {
            "address_prefixes" = ["10.216.110.0/24"]
        }
        //Subnet for DevOps PROD Apps: Not created yet as of 4/21/2024
            "snet-prodappsrv-10.216.100.0_24" = {
            "address_prefixes" = ["10.216.100.0/24"]
        }
        //Subnet for DevOps PROD DB: Not created yet as of 4/21/2024
            "snet-proddatabase-10.216.110.0_24" = {
            "address_prefixes" = ["10.216.110.0/24"]
        }
    }
    location = "eastus"
}