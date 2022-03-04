terraform {
  required_version = ">= 1.0.0"
  experiments      = [module_variable_optional_attrs]

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.90"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 3.90"
    }
  }
}
