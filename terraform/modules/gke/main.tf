resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.location
  initial_node_count = 3  # Adjust for prod

  remove_default_node_pool = true
  node_config {
    machine_type = "e2-medium"  # Cost-effective
    oauth_scopes = ["cloud-platform"]
  }

  master_auth {
    username = ""
    password = ""
    client_certificate_config { issue_client_certificate = false }
  }

  # Enable Workload Identity for secure image pulls from GAR
  workload_identity_config { workload_pool = "${var.project_id}.svc.id.goog" }

  depends_on = [var.gar_repo_url]  # Ensure GAR exists
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "${var.cluster_name}-nodes"
  location   = var.location
  cluster    = google_container_cluster.primary.name
  node_count = 2

  node_config {
    machine_type = "e2-medium"
    oauth_scopes = ["cloud-platform"]
  }
}

output "endpoint" { value = google_container_cluster.primary.endpoint }
output "ca_certificate" { value = google_container_cluster.primary.master_auth.0.cluster_ca_certificate }