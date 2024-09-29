terraform {
  required_version = ">= 1.1.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"  
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

variable "enable" {
  description = "Enable or disable the VPC"
  type        = bool
  default     = true
}
##---------------------------------VPC-------------------------------------------------##

module "vpc" {
  source = "./module/VPC/"
  
  cidr_block         = "10.0.0.0/16"
  instance_tenancy   = var.enable ? "default" : "dedicated"
  enable             = var.enable
}

##---------------------------------EC2-------------------------------------------------##

module "ec2" {
  source = "./module/EC2/"
  vpc_id            = module.VPC.vpc_id
  ssh_allowed_ip    = ["0.0.0.0/0"]
  ssh_allowed_ports = [22]
  #Instance
  instance_count = 1
  ami            = "ami-0ebfd941bbafe70c6"
  instance_type  = "t2.micro"

  #Keypair
  public_key = ""

  subnet_id = module.vpc.subnet_id
  associate_public_ip_address = true

  #Root Volume
  root_block_device = [
    {
      volume_type           = "gp2"
      volume_size           = 15
      delete_on_termination = true
    }
  ]

  #EBS Volume
  ebs_volume_enabled = true
  ebs_volume_type    = "gp2"
  ebs_volume_size    = 30

}
