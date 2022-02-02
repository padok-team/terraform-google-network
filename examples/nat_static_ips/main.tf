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

  name                 = "my-super-network"
  enable_nat_static_ip = true

  subnets = {
    "my-subnet1" = {
      cidr   = "10.20.0.0/16"
      region = "europe-west3"
    }
    "my-subnet2" = {
      cidr   = "10.21.0.0/16"
      region = "europe-west1"
    }
  }
}

