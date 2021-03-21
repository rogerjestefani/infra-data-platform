variable "project_id" {
  description = "GCP Project ID."
}

variable "zone" {
  description = "GCP ZOne"
}

variable "region" {
  description = "GCP Region"
}

variable "storage_class" {
  description = "GCP Storage Class Bucket"
  type        = string
  default     = "REGIONAL"
}

# Private Range IPs GKE
variable "private_subnet_cidr_gke" {
  description = "Private Subnet CIDR"
  type        = string
  default     = "10.160.2.0/28"
}

variable "private_subnet_cidr_pods" {
  description = "Private Subnet CIDR - POD"
  type        = string
  default     = "10.160.2.64/27"
}

variable "private_subnet_cidr_services" {
  description = "Private Subnet CIDR - SERVICE"
  type        = string
  default     = "10.160.2.96/27"
}
