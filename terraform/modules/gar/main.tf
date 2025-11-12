resource "google_artifact_registry_repository" "main" {
  provider      = google-beta
  location      = var.location
  repository_id = var.repo_name
  format        = "DOCKER"
  project       = var.project_id
}

output "gar_repo_url" { value = google_artifact_registry_repository.main.repository_url }