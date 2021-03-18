# Create a GCS Datalake Bucket 
resource "google_storage_bucket" "stage_data" {
  name          = "dl_stage"
  location      = var.region
  force_destroy = true
  storage_class = var.storage_class
}

resource "google_storage_bucket" "raw_data" {
  name          = "dl_raw"
  location      = var.region
  force_destroy = true
  storage_class = var.storage_class
}

resource "google_storage_bucket" "trust_data" {
  name          = "dl_trust"
  location      = var.region
  force_destroy = true
  storage_class = var.storage_class
}

resource "google_storage_bucket" "sandbox_data" {
  name          = "dl_sandbox"
  location      = var.region
  force_destroy = true
  storage_class = var.storage_class
}

resource "google_storage_bucket" "refined_data" {
  name          = "dl_refined"
  location      = var.region
  force_destroy = true
  storage_class = var.storage_class
}
