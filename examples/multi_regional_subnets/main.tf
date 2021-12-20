provider "google" {
  project = "<YOUR_PROJECT_ID>"
  region  = "europe-west3"
}

provider "google-beta" {
  project = "<YOUR_PROJECT_ID>"
  region  = "europe-west3"
}

module "my_network" {
  source = "../.."

  project = "<YOUR_PROJECT_ID>"
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
