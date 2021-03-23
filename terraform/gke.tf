resource "google_service_account" "gke_sa" {
  account_id   = "${var.gke_name}-sa"
  display_name = "${var.gke_name}-sa"
}

resource "google_container_cluster" "gke_cluster" {
  provider = google-beta
  depends_on = [
    google_compute_network.vpc,
    google_compute_subnetwork.private_subnet_gke
  ]
  name                     = var.gke_name
  location                 = var.zone
  remove_default_node_pool = true
  initial_node_count       = 1


  master_authorized_networks_config {
    cidr_blocks {
        cidr_block   = var.private_subnet_cidr
        display_name = "infra"
    }
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.private_subnet_gke.name

  private_cluster_config {
    enable_private_endpoint = "true"
    enable_private_nodes    = "true"
    master_ipv4_cidr_block  = var.private_subnet_cidr_gke_master
  }

}

resource "google_container_node_pool" "deploy_nodes" {
  name       = "deploy-nodes"
  location   = var.zone
  cluster    = var.gke_name
  node_count = 3

  depends_on = [
    google_container_cluster.gke_cluster
  ]

  node_config {
    preemptible     = false
    machine_type    = "n1-standard-4"
    service_account = google_service_account.gke_sa.email

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_write",
    ]
  }
}

resource "google_container_node_pool" "preemptible_nodes" {
  name       = "preemptible-nodes"
  location   = var.zone
  cluster    = var.gke_name
  node_count = 0

  depends_on = [
    google_container_cluster.gke_cluster
  ]

  autoscaling {
    min_node_count = "0"
    max_node_count = "3"
  }

  node_config {
    preemptible     = true
    machine_type    = "n1-highmem-4"
    service_account = google_service_account.gke_sa.email

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_write",
    ]
  }
}
