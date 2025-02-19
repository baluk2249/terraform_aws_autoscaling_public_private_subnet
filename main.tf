terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 3.0"
        }
    }
    backend "s3" {
    bucket = "demo-trout-terraform-state" 
    key    = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "demo-tryout-terraform-state"
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
}