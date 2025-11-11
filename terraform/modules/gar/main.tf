resource "google_artifact_registry_repository" "main" {
  location      = var.location
  repository_id = var.repo_name
  format        = "DOCKER"
  project       = var.project_id
}

output "repository_url" { value = google_artifact_registry_repository.main.repository_url }