# Allow Internal
resource "google_compute_firewall" "allow-internal-gke" {
  name    = "${var.project_id}-fw-allow-internal-gke"
  network = google_compute_network.vpc.name
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  source_ranges = [
    var.private_subnet_cidr_gke
  ]
}