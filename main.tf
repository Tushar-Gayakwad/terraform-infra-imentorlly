terraform {
  required_version = ">= 1.1.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"  # Allows any 3.x version
    }
  }
}
provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
}

module "vpc" {
  source = "./module/VPC/"

  cidr_block                       = "10.0.0.0/16"
  instance_tenancy                 = var.enable ? "default" : "dedicated"
  enable                           = true
#   flow_log_destination_type        = "s3"
#   flow_logs_bucket_name            = "gc-vpc-flow-logs-bucket"
#   additional_cidr_block            = ["172.3.0.0/16", "172.2.0.0/16"]
#   dhcp_options_domain_name         = "service.consul"
#   dhcp_options_domain_name_servers  = ["127.0.0.1", "10.10.0.2"]
}
