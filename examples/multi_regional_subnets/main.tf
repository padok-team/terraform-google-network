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

  project = "padok-cloud-factory"
  delete_default_network = true
  name = "my-super-network"
  subnets = {
    "my-subnet1" = {
      cidr = "10.20.0.0/16"
      region = "europe-west3"
    }
    "my-subnet2" = {
      cidr = "10.21.0.0/16"
      region = "europe-west1"
    }
  }
}
