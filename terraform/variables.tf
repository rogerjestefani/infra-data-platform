variable "project_id" {
  description = "GCP Project ID."
  type        = string
  default     = "abiding-window-307913"
}

variable "project_sa_key" {
  description = "GCP SA Key Project ID."
  type        = string
  default     = "/home/roger/Downloads/infra.json"
}

variable "zone" {
  description = "GCP ZOne"
  type        = string
  default     = "us-east1-b"
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "us-east1"
}

variable "storage_class" {
  description = "GCP Storage Class Bucket"
  type        = string
  default     = "REGIONAL"
}