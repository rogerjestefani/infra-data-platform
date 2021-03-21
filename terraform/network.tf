# VPC
resource "google_compute_network" "vpc" {
  name                    = "${var.project_id}-vpc"
  auto_create_subnetworks = "false"
  routing_mode            = "GLOBAL"
}

# Public IP NAT Service
resource "google_compute_address" "nat_ip" {
  name    = "${var.project_id}-nap-ip"
  project = var.project_id
  region  = var.region
}

# Allow private instances connect internet at NAT
resource "google_compute_router" "nat_router" {
  name    = "${var.project_id}-nat-router"
  network = google_compute_network.vpc.name
}

resource "google_compute_router_nat" "nat_gateway" {
  name                               = "${var.project_id}-nat-gateway"
  router                             = google_compute_router.nat_router.name
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = [google_compute_address.nat_ip.self_link]
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  depends_on                         = [google_compute_address.nat_ip]
}

# NAT IP Address
output "nat_ip_address" {
  value = google_compute_address.nat_ip.address
}

# Private Subnet Gke
resource "google_compute_subnetwork" "private_subnet_gke" {
  provider                 = google-beta
  purpose                  = "PRIVATE"
  name                     = "${var.project_id}-private-subnet-gke"
  ip_cidr_range            = var.private_subnet_cidr_gke
  network                  = google_compute_network.vpc.name
  region                   = var.region
  private_ip_google_access = "true"
  secondary_ip_range = [
      {
          range_name = "pods"
          ip_cidr_range = var.private_subnet_cidr_pods
      },
      {
          range_name = "services"
          ip_cidr_range = var.private_subnet_cidr_services
      },
  ]
}