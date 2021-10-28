variable "project" {
  type = string
  description = "Google Cloud Platform project"
  default = null
}

variable "region" {
  type = string
  description = "Google Cloud Platform region"
  default = null
}

variable "network_name" {
  type        = string
  description = "Name of the network"
  validation {
    condition     =  length(var.network_name) > 1 && length(var.network_name) <= 63
    error_message = "The name must be 1-63 characters long ."
  }

  validation {
    condition     =  can(regex("^[a-z]([-a-z0-9]*[a-z0-9])?", var.network_name))
    error_message = "The name must match the regular expression ^[a-z]([-a-z0-9]*[a-z0-9])? ."
  }
}

variable "subnets" {
  type        = map(object({
    cidr   = string
    region = optional(string)
  }))
  description = "Subnets list"
  validation {
    condition     = can([for k, v in var.subnets : length(k) > 1 && length(k) <= 63])
    error_message = "The name must be 1-63 characters long ."
  }
   validation {
    condition     = can([for k, v in var.subnets : can(regex("^[a-z]([-a-z0-9]*[a-z0-9])?", k))])
    error_message = "The name must match the regular expression ^[a-z]([-a-z0-9]*[a-z0-9])? ."
  }
  validation {
    condition     = can([for k, v in var.subnets : regex("^([0-9]{1,3}.){3}[0-9]{1,3}[\\/](([0-9]|[1-2][0-9]|3[0-2]))+$", v.cidr)])
    error_message = "Your CIDR must match the following pattern XX.XX.XX.XX/YY (e.g. 192.168.0.1/32)."
  }
}

variable "routing_mode" {
  type        = string
  default     = "REGIONAL"
  description = "The network-wide routing mode to use. If set to REGIONAL, this network's cloud routers will only advertise routes with subnetworks of this network in the same region as the router. If set to GLOBAL, this network's cloud routers will advertise routes with all subnetworks of this network, across regions. "
}

variable "cloudsql" {
  type        = bool
  default     = false
  description = "If true, create VPC peering for CloudSQL."

}

variable "cloudrun" {
  type        = bool
  default     = false
  description = "If true, create a VPC network used by Cloud Run instances to access VPC resources."
}

variable "delete_default_network" {
  type        = bool
  default     = false
  description = "If true, create a VPC network used by Cloud Run instances to access VPC resources."
}
