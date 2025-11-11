terraform {
  required_version = ">= 1.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  credentials = var.gcp_sa_key  # From Azure DevOps var
  project     = var.project_id
  region      = var.region      # e.g., "us-central1"
}