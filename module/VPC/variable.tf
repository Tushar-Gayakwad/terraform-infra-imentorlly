variable "enable" {
  type        = bool
  default     = true
  description = "Flag to control the VPC creation."
}

variable "cidr_block" {
  type        = string
  default     = ""
  description = "CIDR for the VPC."
}

variable "ipam_pool_enable" {
  type        = bool
  default     = false
  description = "Flag to be set true when using IPAM for CIDR."
}

variable "instance_tenancy" {
  type        = string
  default     = "default"
  description = "A tenancy option for instances launched into the VPC."
}

variable "tags_name" {
  type        = string
  default     = "default"
  description = "Tag for the VPC."
}

variable "aws_default_route_table" {
  type        = bool
  default     = true
  description = "A boolean flag to enable/disable Default Route Table in the VPC."
}

variable "default_route_table_routes" {
  type        = list(map(string))
  default     = []
  description = "Configuration block of routes."
}
variable "availability_zones" {
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]  # Adjust as needed
  description = "List of Availability Zones."
}

variable "subnet_cidr_block" {
  type        = string
  default     = "10.0.1.0/24"  # Adjust as necessary
  description = "CIDR for the Subnet."
}
