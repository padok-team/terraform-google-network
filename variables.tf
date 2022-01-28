variable "name" {
  description = "Name of the network"
  type        = string
  validation {
    condition     = length(var.name) > 1 && length(var.name) <= 63
    error_message = "The name must be 1-63 characters long."
  }

  validation {
    condition     = can(regex("^[a-z]([-a-z0-9]*[a-z0-9])?", var.name))
    error_message = "The name must match the regular expression ^[a-z]([-a-z0-9]*[a-z0-9])?."
  }
}

variable "subnets" {
  description = "Subnets list."
  type = map(object({
    cidr   = string
    region = string
  }))

  validation {
    condition     = can([for k, v in var.subnets : length(k) > 1 && length(k) <= 63])
    error_message = "The name must be 1-63 characters long."
  }
  validation {
    condition     = can([for k, v in var.subnets : can(regex("^[a-z]([-a-z0-9]*[a-z0-9])?", k))])
    error_message = "The name must match the regular expression ^[a-z]([-a-z0-9]*[a-z0-9])?."
  }
  validation {
    condition     = can([for k, v in var.subnets : regex("^([0-9]{1,3}.){3}[0-9]{1,3}[\\/](([0-9]|[1-2][0-9]|3[0-2]))+$", v.cidr)])
    error_message = "Your CIDR must match the following pattern XX.XX.XX.XX/YY (e.g. 192.168.0.1/32)."
  }
}

variable "routing_mode" {
  description = "The network-wide routing mode to use. If set to REGIONAL, this network's cloud routers will only advertise routes with subnetworks of this network in the same region as the router. If set to GLOBAL, this network's cloud routers will advertise routes with all subnetworks of this network, across regions."
  type        = string
  default     = "REGIONAL"
}

variable "cloudrun" {
  description = "If true, create a VPC network used by Cloud Run instances to access VPC resources."
  type        = bool
  default     = false
}

variable "log_config_enable" {
  description = "Indicates whether or not to export logs."
  type        = bool
  default     = false
}

variable "log_config_filter" {
  description = "Specifies the desired filtering of logs on this NAT. Possible values are ERRORS_ONLY, TRANSLATIONS_ONLY, and ALL."
  type        = string
  default     = "ERRORS_ONLY"
}

variable "peerings" {
  description = "Map of all the peerings to create with."
  type = map(object({
    address = string
    prefix  = number
  }))
  default = {}
}
