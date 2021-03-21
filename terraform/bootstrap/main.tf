terraform {
  required_version = ">= 0.14"
}

provider "google" {
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}

provider "google-beta" {
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}

resource "google_storage_bucket" "tf-state-data-platform-model" {
  name          = "tf-state-data-platform-model"
  location      = var.region
  force_destroy = true
  storage_class = var.storage_class
}