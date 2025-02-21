variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
  
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for the private subnets"
  type        = list(string)
  
}



variable "web_sg_cidr_blocks" {
  description = "CIDR blocks to allow HTTP access"
  type        = list(string)
  
}

variable "web_asg_22_cidr_blocks" {
  description = "CIDR blocks to allow HTTP access"
  type        = list(string)
  
}

variable "web_asg_80_cidr_blocks" {
  description = "CIDR blocks to allow HTTP access"
  type        = list(string)
  
}

