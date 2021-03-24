# GKE USER
resource "google_service_account" "gke_sa" {
  account_id   = "${var.gke_name}-sa"
  display_name = "${var.gke_name}-sa"
}

# BIGQUERY USER
resource "google_service_account" "bigquery_sa" {
  account_id   = "bigquery-sa"
  display_name = "bigquery-sa"
}

resource "google_service_account_iam_binding" "service-account-iam-gke" {
  service_account_id = google_service_account.gke_sa.name
  role               = "roles/iam.serviceAccountUser"

  members = [
    "serviceAccount:${var.infra_sa}",
  ]
}

resource "google_service_account_iam_binding" "service-account-iam-big" {
  service_account_id = google_service_account.bigquery_sa.name
  role               = "roles/iam.serviceAccountUser"

  members = [
    "serviceAccount:${var.infra_sa}",
  ]
}
