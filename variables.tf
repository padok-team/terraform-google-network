#
# ROOT MODULE
#

variable "project_id" {
  description = "The ID of the project where this VPC will be created"
}

variable "name" {
  description = "The name of the network being created"
}

variable "routing_mode" {
  type        = string
  default     = "GLOBAL"
  description = "The network routing mode (default 'GLOBAL')."
}

variable "subnets" {
  type = map(object({
    name            = string
    region          = string
    primary_cidr    = string
    serverless_cidr = string
    secondary_ranges = map(object({
      name = string
      cidr = string
    }))
  }))
  description = "The list of subnets beeing created"
}

variable "gcp_peering_cidr" {
  type        = string
  description = "CIDR to reserve for GCP service in this VPC"
}
