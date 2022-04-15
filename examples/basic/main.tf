module "basic" {
  source = "../.."

  network_name = "testing"
  project_id   = "padok-host"
  subnets = [
    {
      subnet_name   = "eu"
      subnet_ip     = "172.16.48.0/20"
      subnet_region = "europe-west1"
    },
    {
      subnet_name   = "us"
      subnet_ip     = "172.16.96.0/20"
      subnet_region = "northamerica-northeast1"
    }
  ]
  gcp_services_cidr = "172.16.64.0/20"
  vpc_serverless_connectors = [{
    name   = "eu"
    cidr   = "172.16.80.0/20"
    region = "europe-west1"
  }]
}
