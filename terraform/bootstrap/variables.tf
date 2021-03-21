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
