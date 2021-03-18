terraform {
  required_version = ">= 0.14"
}

provider "google" {
  credentials = file(var.project_sa_key)
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}

# provider "google-beta" {
#   credentials = file(var.project_sa_key)
#   project     = var.project_id
#   region      = var.region
#   zone        = var.zone
# }
