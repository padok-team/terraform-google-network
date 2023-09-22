name       = "testing"
project_id = "padok-library-gcp-host"

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
}
gcp_peering_cidr = "172.16.64.0/20"
