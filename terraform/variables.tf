variable "project_id" { type = string }
variable "gcp_sa_key" { type = string}
variable "region" { default = "us-central1" }
variable "gar_repo_name" { default = "webapp-images" }
variable "gke_cluster_name" { default = "webapp-cluster" }