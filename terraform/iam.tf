resource "google_service_account" "gke_sa" {
  account_id   = "${var.gke_name}-sa"
  display_name = "${var.gke_name}-sa"
}

resource "google_service_account" "bigquery_sa" {
  account_id   = "bigquery-sa"
  display_name = "bigquery-sa"
}
