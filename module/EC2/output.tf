output "vpc_default_security_group_id" {
  value       = join("", aws_vpc.default[*].default_security_group_id)
  description = "The ID of the security group created by default on VPC creation."
}
