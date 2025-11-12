provider "google" {
  project = var.project_id
  region  = var.location
}


module "gar" {
  source     = "./modules/gar"
  project_id = var.project_id
  repo_name  = var.gar_repo_name
  location   = var.location
}

module "gke" {
  source          = "./modules/gke"
  cluster_name     = var.cluster_name
  location = var.location
  node_count = var.node_count
  machine_type =var.machine_type
  service_account_email = var.service_account_email
  project_id      = var.project_id
  depends_on      = [module.gar]
}