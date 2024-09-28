output "vpc_id" {
  value       = aws_vpc.imentorlly[0].id
  description = "The ID of the VPC."
}

output "vpc_cidr_block" {
  value       = aws_vpc.imentorlly[0].cidr_block
  description = "The CIDR block of the VPC."
}

output "vpc_main_route_table_id" {
  value       = aws_vpc.imentorlly[0].main_route_table_id
  description = "The ID of the main route table associated with this VPC."
}

output "igw_id" {
  value       = aws_internet_gateway.default.id
  description = "The ID of the Internet Gateway."
}
