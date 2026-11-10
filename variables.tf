variable "ibmcloud_api_key" {
  description = "IBM Cloud platform API key required if terraform is launched outside of Schematics"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "IBM Cloud region where to deploy the resources"
  type        = string
  default     = "eu-de"
  nullable    = false

  validation {
    condition     = contains(["us-south", "us-east", "eu-gb", "eu-de", "jp-tok", "jp-osa", "au-syd", "ca-tor", "br-sao", "in-che", "mad"], var.region)
    error_message = "The region must be a valid IBM Cloud VPC region (e.g., eu-de, eu-gb, us-south, us-east)."
  }
}

variable "prefix" {
  description = "A prefix for all resources to be created (lowercase alphanumeric and hyphens, max 16 chars). If none provided, a random prefix will be generated"
  type        = string
  default     = ""

  validation {
    condition     = length(var.prefix) <= 16 && can(regex("^[a-z0-9-]*$", var.prefix))
    error_message = "Prefix must be at most 16 characters long and contain only lowercase alphanumeric characters and hyphens."
  }
}

variable "existing_resource_group_name" {
  description = "Name of an existing resource group where to create resources (optional)"
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "IPv4 CIDR block allowed to connect to the VSI via SSH"
  type        = string
  default     = "0.0.0.0/0"
  nullable    = false

  validation {
    condition     = can(cidrnetmask(var.allowed_ssh_cidr))
    error_message = "The allowed_ssh_cidr variable must be a valid IPv4 CIDR block (e.g., 0.0.0.0/0, 10.0.0.0/8, 192.168.1.50/32)."
  }
}

variable "image_name" {
  description = "Name of the OS image to use for the private instance"
  type        = string
  default     = "ibm-ubuntu-24-04-minimal-amd64-1"
}

variable "profile_name" {
  description = "Instance profile for the VSI (e.g., cx2-2x4, bx2-2x8, mx2-2x16)"
  type        = string
  default     = "cx2-2x4"
  nullable    = false

  validation {
    condition     = can(regex("^[a-z]{2}[0-9]-[0-9]+x[0-9]+$", var.profile_name))
    error_message = "Profile name must follow standard IBM Cloud VSI profile format (e.g., cx2-2x4, bx2-4x8)."
  }
}

variable "ssh_public_key" {
  description = "SSH Public Key. Get your ssh key by running `ssh-keygen` command"
  type        = string
  default     = null
}

variable "ssh_key_id" {
  description = "ID of SSH public key stored in IBM Cloud"
  type        = string
  default     = null
}

variable "tags" {
  description = "List of tags to apply to all provisioned resources"
  type        = list(string)
  default     = ["tf", "training"]

  validation {
    condition     = alltrue([for t in var.tags : can(regex("^[a-z0-9-_:]+$", t))])
    error_message = "Each tag must contain only lowercase alphanumeric characters, dashes, underscores, and colons."
  }
}
