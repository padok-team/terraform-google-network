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
  #checkov:skip=CKV_TF_1 Ensure Terraform module sources use a commit hash
  source       = "github.com/padok-team/terraform-google-serviceaccount?ref=v2.0.0"
  name         = "identity-terraform-gcp-network"
  project_id   = data.google_client_config.this.project
  display_name = "Service Account for padok-team/terraform-google-network Github Action"
}

module "gh_oidc" {
  #checkov:skip=CKV_TF_1 Ensure Terraform module sources use a commit hash
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

resource "google_project_iam_member" "github_actions_read_scan_result" {
  project = data.google_client_config.this.project

  role   = "roles/editor"
  member = "serviceAccount:${module.github_action_enabler_padok_lab_sa.this.email}"
}

output "sa_email" {
  value = module.github_action_enabler_padok_lab_sa.this.email
}

output "project_id" {
  value = data.google_client_config.this.project
}
