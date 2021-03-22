resource "google_compute_instance" "bastion" {
  name                      = "bastion"
  machine_type              = "n1-standard-1"
  zone                      = var.zone
  allow_stopping_for_update = true
  can_ip_forward            = true

  tags = ["bastion"]

  depends_on = [
    google_compute_subnetwork.private_subnet_bastion
  ]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.private_subnet_bastion.name
    network_ip = "10.100.0.10"

  }
  metadata_startup_script = <<SCRIPT
sudo apt update -y
sudo apt upgrade -y
sudo sysctl -w net.ipv4.ip_forward=1
echo "net.ipv4.ip_forward=1" | sudo tee -a /etc/sysctl.conf > /dev/null
SCRIPT
}
