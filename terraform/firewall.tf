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
    var.private_subnet_cidr
  ]
}

# Allow SSH BASTION
# https://cloud.google.com/solutions/building-internet-connectivity-for-private-vms?hl=pt-br#create_firewall_rules_to_allow_tunneling
resource "google_compute_firewall" "allow-ssh" {
  name    = "${var.project_id}-fw-allow-ssh"
  network = google_compute_network.vpc.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = [
    "35.235.240.0/20"
  ]
  target_tags = [
    "bastion"
  ]
}
