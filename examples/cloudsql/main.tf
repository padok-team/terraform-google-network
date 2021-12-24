# Short description of the use case in comments

provider "google" {
  project = "padok-cloud-factory"
  region  = "europe-west3"
}

provider "google-beta" {
  project = "padok-cloud-factory"
  region  = "europe-west3"
}

module "my_network" {
  source = "../.."

  name = "my-super-network-3"
  subnets = {
    "private-subnet-1" = {
      cidr   = "10.20.0.0/16"
      region = "europe-west3"
    }
  }
  peerings = {
    cloudsql = {
      address = "10.0.1.0"
      prefix  = 24
    }
  }
}
