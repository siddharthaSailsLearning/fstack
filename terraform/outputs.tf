output "gar_repo_url" { value = google_artifact_registry_repository.main.repository_url }
output "gke_endpoint" { value = module.gke.endpoint }
output "gke_ca_cert" { value = module.gke.ca_certificate }