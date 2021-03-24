variable "project_id" {
  description = "GCP Project ID."
}

variable "infra_sa" {
  description = "GCP ServiceAccount."
}

variable "zone" {
  description = "GCP ZOne"
}

variable "region" {
  description = "GCP Region"
}

variable "gke_name" {
  description = "GCP GKE Name"
}

variable "folder_files_path" {
 type        = string
 description = "Path folder File"
}

variable "storage_class" {
  description = "GCP Storage Class Bucket"
  type        = string
  default     = "REGIONAL"
}

# Private Range IPs
variable "private_subnet_cidr" {
  description = "Private Subnet CIDR"
  type        = string
  default     = "10.0.0.0/8"
}

# Private Range IPs GKE Master
variable "private_subnet_cidr_gke_master" {
  description = "Private Subnet CIDR Master"
  type        = string
  default     = "10.5.0.0/28"
}

# Private Range IPs GKE
variable "private_subnet_cidr_gke" {
  description = "Private Subnet CIDR"
  type        = string
  default     = "10.10.0.0/24"
}

variable "private_subnet_cidr_pods" {
  description = "Private Subnet CIDR - POD"
  type        = string
  default     = "10.20.0.0/14"
}

variable "private_subnet_cidr_services" {
  description = "Private Subnet CIDR - SERVICE"
  type        = string
  default     = "10.30.0.0/20"
}
# Subnet CIDR Bastion
variable "private_subnet_cidr_bastion" {
  description = "Private Subnet CIDR Bastion"
  type        = string
  default     = "10.1.1.0/29"
}