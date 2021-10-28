# Short description of the use case in comments

provider "google" {
  project = "padok-cloud-factory"
  region  = "europe-west3"
}

provider "google-beta" {
  project = "padok-cloud-factory"
  region  = "europe-west3"
}

module "use_case_1" {
  source = "../.."

  network_name = "my-super-network"
  subnets = {
    "my-subnet1" = {
      cidr = "10.20.0.0/16"c
      region = "europe-west3"
    }
  }
  cloudsql = true
}
