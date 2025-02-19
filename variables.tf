variable "region" {
  description = "AWS region"
  type        = string
  default = "us-east-1"
  
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default = "10.0.0.0/20"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
  
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for the private subnets"
  type        = list(string)
  default = ["10.0.0.0/23","10.0.2.0/23","10.0.4.0/23"]
  
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
  default = ["10.0.6.0/23","10.0.8.0/23","10.0.10.0/23"]
  
}