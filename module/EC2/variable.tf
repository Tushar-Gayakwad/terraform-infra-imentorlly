variable "availability_zone" {
  description = "AZ to start the instance in"
  type        = string
  default     = null
}
variable "associate_public_ip_address" {
  type        = bool
  default     = true
  description = "Associate a public IP address with the instance."
  sensitive   = true
}
variable "instance_type" {
  type        = string
  description = "The type of instance to start. Updates to this field will trigger a stop/start of the EC2 instance."
}
variable "ebs_optimized" {
  type        = bool
  default     = false
  description = "If true, the launched EC2 instance will be EBS-optimized."
}
variable "ami" {
  type        = string
  default     = ""
  description = "The AMI to use for the instance."
}
