terraform {
  required_version = "~> 1.5.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.62"
    }
  }
}

provider "google" {
  project = "padok-library-gcp-host"
  region  = "europe-west9"
}

data "google_client_config" "this" {}

module "github_action_enabler_padok_lab_sa" {
  source       = "github.com/padok-team/terraform-google-serviceaccount?ref=v2.0.0"
  name         = "identity-terraform-gcp-network"
  project_id   = data.google_client_config.this.project
  display_name = "Service Account for padok-team/terraform-google-network Github Action"
}

module "gh_oidc" {
  source      = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  version     = "v3.1.1"
  project_id  = data.google_client_config.this.project
  pool_id     = "identity-terraform-gpc-network"
  provider_id = "identity-terraform-gcp-network"
  sa_mapping = {
    "enabler-padok-library-gcp-host-sa" = {
      sa_name = "projects/${data.google_client_config.this.project}/serviceAccounts/${module.github_action_enabler_padok_lab_sa.this.email}"
      # github.com/padok-team/enabler-github-app
      attribute = "attribute.repository/padok-team/terraform-google-network"
    }
  }
}

output "sa_email" {
  value = module.github_action_enabler_padok_lab_sa.this.email
}

output "project_id" {
  value = data.google_client_config.this.project
}
