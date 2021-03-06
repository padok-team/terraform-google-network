module "gke" {
  source = "../.."

  name       = "testing"
  project_id = "library-344516"
  subnets = {
    "eu" = {
      name             = "eu"
      region           = "europe-west1"
      primary_cidr     = "172.16.48.0/20"
      serverless_cidr  = ""
      secondary_ranges = {
        pods = {
          name = "gke-pods-main"
          cidr = "10.8.0.0/14"
        },
        services = {
          name = "gke-services-main"
          cidr = "192.168.6.0/23"
        }
      }
    }
  }
  gcp_peering_cidr = "172.16.64.0/20"
}
