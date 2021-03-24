# Spark Scripts
resource "google_storage_bucket" "spark_scripts" {
  name          = "dl_spark_scripts"
  location      = var.region
  force_destroy = true
  storage_class = var.storage_class
}

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

# IAM MEMBER BUCKETS
resource "google_storage_bucket_iam_member" "member_spark_scripts" {
  bucket = google_storage_bucket.spark_scripts.name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${google_service_account.gke_sa.email}"
}

resource "google_storage_bucket_iam_member" "member_raw_data" {
  bucket = google_storage_bucket.raw_data.name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${google_service_account.gke_sa.email}"
}

resource "google_storage_bucket_iam_member" "member_trust_data" {
  bucket = google_storage_bucket.trust_data.name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.gke_sa.email}"
}

# UPLOAD FILES
resource "null_resource" "upload_folder_content" {
  triggers = {
    file_hashes = jsonencode({
      for fn in fileset(var.folder_files_path, "**") :
      fn => filesha256("${var.folder_files_path}/${fn}")
    })
  }

  provisioner "local-exec" {
    command = "gsutil cp -r ${var.folder_files_path}/* gs://${google_storage_bucket.raw_data.name}/"
  }
}

resource "null_resource" "upload_folder_content_scripts" {
  triggers = {
    file_hashes = jsonencode({
      for fn in fileset(var.folder_files_path_scripts, "**") :
      fn => filesha256("${var.folder_files_path_scripts}/${fn}")
    })
  }

  provisioner "local-exec" {
    command = "gsutil cp -r ${var.folder_files_path_scripts}/* gs://${google_storage_bucket.spark_scripts.name}/"
  }
}
