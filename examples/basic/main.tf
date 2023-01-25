module "basic" {
  source = "../.."

  name       = "testing"
  project_id = "padok-library-gcp-host"

  nats = {
    "europe-west1" = {
      mode      = "DYNAMIC_PORT_ALLOCATION"
      min_ports = 64
      max_ports = 2048
    }
    "europe-west2" = {
      min_ports = 1024
    }
  }

  subnets = {
    "eu-1" = {
      name             = "eu-1"
      region           = "europe-west1"
      primary_cidr     = "172.16.0.0/20"
      serverless_cidr  = ""
      secondary_ranges = {}
    },
    "eu-2" = {
      name             = "eu-2"
      region           = "europe-west2"
      primary_cidr     = "172.16.48.0/20"
      serverless_cidr  = "172.16.80.0/28"
      secondary_ranges = {}
    }
    "us" = {
      name             = "us"
      region           = "northamerica-northeast1"
      primary_cidr     = "172.16.96.0/20"
      serverless_cidr  = ""
      secondary_ranges = {}
    }
  }
  gcp_peering_cidr = "172.16.64.0/20"
}
