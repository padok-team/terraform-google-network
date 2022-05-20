# Goal

# * Create router
# * Create NAT addresses
# * Create network
# * Create subnetworks
# * Google network peering (SQL et Serverless)
# * Have a simple interface

# Interface and implementation

# NETWORK ROOT MODULE
```hcl
module "network" {
    source = "../network"
    project_id = string

    name = "hors-prod"
    
    subnets = {
      staging = {
        name          = "staging" # MANDATORY
        region        = "europe-west1" # MANDATORY
        primary_cidr  = "172.17.16.0/21" # MANDATORY
        serverless_cidr = "" # If empty don't create it!
        secondary_ranges = {
          pods = {
            name = "pods"
            cidr = "10.0.0.0/8"
          },
          services = {
            name = "services"
            cidr = "10.0.0.0/8"
          }
        }
      },
      poc = {
        name          = "staging" # MANDATORY
        region        = "europe-west1" # MANDATORY
        primary_cidr  = "172.17.16.0/21" # MANDATORY
        serverless_cidr = "" # If empty don't create it!
        secondary_ranges = {
          pods = {
            name = "pods"
            cidr = "10.0.0.0/8"
          },
          services = {
            name = "services"
            cidr = "10.0.0.0/8"
          }
        }
      },
    }

    gcp_peering_cidr = "" # If empty don't create it!

    routing_mode = "REGIONAL" # This is an overrided value, the default is GLOBAL
}

# NETWORK ROOT SUBMODULE GKE
module "subnetwork" {
    source = "../network//gke"
    
    project_id = string
    region        = "europe-west1" # MANDATORY

    name = "poc"
    network = "hors-prod"
    primary_cidr  = "172.17.16.0/21" # MANDATORY
    pods_cidr     = "" # If empty don't create it! TODO: subnetname-pods
    services_cidr = "" # If empty don't create it! TODO: subnetname-services
}

## >> Sub module
# production = {
#   name          = "production" # MANDATORY
#   region        = "europe-west1" # MANDATORY
#   primary_cidr  = "172.28.16.0/21" # MANDATORY
#   pods_cidr     = "" # If empty don't create it! TODO: subnetname-pods
#   services_cidr = "" # If empty don't create it! TODO: subnetname-services
# },

local {
  networks = {
    non-production = {
      name = "non-production"
      subnets = {
        staging = {
          name          = "staging"
          primary_cidr  = "172.17.16.0/21"
          pods_cidr     = "" 
          services_cidr = null # OR ""
        },
      },
      gcp_services_cidr = ""
      serverless_cidr   = ""
    },
    production = {
      name = "production"
      subnets = {
        production = {
          name          = "production"
          primary_cidr  = "172.17.24.0/21"
          pods_cidr     = "10.8.0.0/14"
          services_cidr = "192.168.6.0/23"
        },
      },
      gcp_services_cidr = "172.17.0.0/21"
      serverless_cidr   = "192.168.132.0/28"
    },
  }
}

module "vpc_gke" {
  source   = "git@github.com:padok-team/terraform-google-network.git//modules/gke-network?ref=feat/refacto-module" #TODO: module/submodule + tag
  for_each = local.networks

  project_id = module.project.project_id

  name              = each.value.name
  subnets           = each.value.subnets
  gcp_services_cidr = each.value.gcp_services_cidr
  serverless_cidr   = each.value.serverless_cidr
}



local {
  networks_base = {
    non-production = {
      name = "non-production"
      subnets = [
        {
          subnet_name               = "subnet-03"
          subnet_ip                 = "10.10.30.0/24"
          subnet_region             = "us-west1"
          subnet_flow_logs          = "true"
          subnet_flow_logs_interval = "INTERVAL_10_MIN"
          subnet_flow_logs_sampling = 0.7
          subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
        }
      ]
      gcp_services_cidr = ""
      serverless_cidr   = ""
    },
    production = {
      name = "production"
      subnets = [
        {
          subnet_name               = "subnet-03"
          subnet_ip                 = "10.10.30.0/24"
          subnet_region             = "us-west1"
          subnet_flow_logs          = "true"
          subnet_flow_logs_interval = "INTERVAL_10_MIN"
          subnet_flow_logs_sampling = 0.7
          subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
        }
      ]
      gcp_services_cidr = "172.17.0.0/21"
      serverless_cidr   = "192.168.132.0/28"
    },
  }
}

module "vpc" {
  source   = "git@github.com:padok-team/terraform-google-network.git?ref=feat/refacto-module" #TODO: module/submodule + tag
  for_each = local.networks_base

  project_id = module.project.project_id

  name              = each.value.name
  subnets           = each.value.subnets
  gcp_services_cidr = each.value.gcp_services_cidr
  serverless_cidr   = each.value.serverless_cidr
}
```
