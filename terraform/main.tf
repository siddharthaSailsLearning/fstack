module "gar" {
  source     = "./modules/gar"
  project_id = var.project_id
  repo_name  = var.gar_repo_name
  location   = var.region
}

module "gke" {
  source          = "./modules/gke"
  project_id      = var.project_id
  cluster_name    = var.gke_cluster_name
  location        = var.region
  gar_repo_url    = module.gar.repository_url  # Optional: For image pull secrets
  depends_on      = [module.gar]
}