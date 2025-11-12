variable "project_id" { type = string }
variable "gcp_sa_key" { type = string}
variable "gar_repo_name" { default = "webapp-images" }
variable "cluster_name" { default = "webapp-cluster" }

variable "location" {
  type    = string
  default = "us-central1"
}

variable "service_account_email" {
  type    = string
  default = "siddhu-service-account@fluted-factor-438905-d2.iam.gserviceaccount.com"
}


variable "node_count" {
  type    = number
  default = 1
}

variable "machine_type" {
  type    = string
  default = "e2-micro"
}