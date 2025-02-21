terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 3.0"
        }
    }
    backend "s3" {
    bucket = var.backend_bucket
    key    = var.backend_key
    region = var.backend_region
    dynamodb_table = var.backend_dyn_table
    encrypt = true  
    }
}

provider "aws" {
    region = var.region
  
}

module "vpc" {
    source = "./modules/vpc"
  
    vpc_cidr = var.vpc_cidr
    availability_zones = var.availability_zones
    public_subnet_cidrs = var.public_subnet_cidrs
    private_subnet_cidrs = var.private_subnet_cidrs
    web_asg_22_cidr_blocks = var.web_asg_22_cidr_blocks
    web_asg_80_cidr_blocks = var.web_asg_80_cidr_blocks
    web_sg_cidr_blocks = var.web_sg_cidr_blocks
}

module "autoscaling" {
    source = "./modules/autoscaling"

    instance_type = var.instance_type
    key_name      = var.key_name
    ami_id = var.ami_id
    web_asg_min_size = var.min_size
    web_asg_max_size = var.max_size
    web_asg_desired_capacity = var.desired_capacity
    web_private_asg_id = module.vpc.web_private_asg_id
    web_asg_subnet_ids = module.vpc.private_subnet_ids
    vpc_id = module.vpc.vpc_id
    public_subnet_ids = module.vpc.public_subnet_ids
  
}