## VPC GOOGLE MODULE VARIABLES

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
  type        = list(map(string))
  description = "The list of subnets being created"
}

# variable "secondary_ranges" {
#   type        = map(list(object({ range_name = string, ip_cidr_range = string })))
#   description = "Secondary ranges that will be used in some of the subnets"
#   default     = {}
# }

# variable "routes" {
#   type        = list(map(string))
#   description = "List of routes being created in this VPC"
#   default     = []
# }

# variable "firewall_rules" {
#   type        = any
#   description = "List of firewall rules"
#   default     = []
# }

# variable "delete_default_internet_gateway_routes" {
#   type        = bool
#   description = "If set, ensure that all routes within the network specified whose names begin with 'default-route' and with a next hop of 'default-internet-gateway' are deleted"
#   default     = false
# }

# variable "description" {
#   type        = string
#   description = "An optional description of this resource. The resource must be recreated to modify this field."
#   default     = ""
# }

# variable "auto_create_subnetworks" {
#   type        = bool
#   description = "When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources."
#   default     = false
# }

# variable "mtu" {
#   type        = number
#   description = "The network MTU. Must be a value between 1460 and 1500 inclusive. If set to 0 (meaning MTU is unset), the network will default to 1460 automatically."
#   default     = 0
# }

## GCP Services CIDR

variable "gcp_peering_cidr" {
  type        = string
  description = "CIDR to reserve for GCP service in this VPC"
}

## Serverless Connectors

# variable "vpc_serverless_connectors" {
#   type        = list(map(string))
#   description = "List of CIDR to be used for vpc_serverless_connectors"
# }
