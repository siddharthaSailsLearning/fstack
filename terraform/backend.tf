terraform {
  required_version = ">= 1.5.0"

  backend "gcs" {
    bucket = "pipeline-tfstate-bucket-for-infra-mgmt"
    prefix = "terraform/state"
  }
}
