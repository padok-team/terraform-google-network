module "basic" {
  source = "../.."

  name       = "testing"
  project_id = "library-344516"
  subnets = {
    "eu" = {
      name             = "eu"
      region           = "europe-west1"
      primary_cidr     = "172.16.48.0/20"
      serverless_cidr  = "172.16.80.0/28"
      secondary_ranges = {}
    },
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
