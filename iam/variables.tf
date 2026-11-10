variable "ibmcloud_api_key" {
  description = "The IBM Cloud platform API key needed to deploy IAM enabled resources"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "IBM Cloud region where all resources will be provisioned"
  type        = string
  default     = "eu-de"
  nullable    = false

  validation {
    condition     = contains(["us-south", "us-east", "eu-gb", "eu-de", "jp-tok", "jp-osa", "au-syd", "ca-tor", "br-sao", "in-che", "mad"], var.region)
    error_message = "The region must be a valid IBM Cloud region (e.g., eu-de, eu-gb, us-south, us-east)."
  }
}

variable "resource_group" {
  description = "Resource group where to create resources"
  type        = string
  default     = "france-hashicorp"
}
