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
  default = ["us-east-1a", "us-east-1b", ]
  
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for the private subnets"
  type        = list(string)
  default = ["10.0.0.0/24","10.0.4.0/24"]
  
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
  default = ["10.0.8.0/24","10.0.12.0/24"]
  
}

variable "web_sg_cidr_blocks" {
  description = "CIDR blocks to allow HTTP access"
  type        = list(string)
  default = [ "0.0.0.0/0" ]
  
}

variable "web_asg_22_cidr_blocks" {
  description = "CIDR blocks to allow HTTP access"
  type        = list(string)
  default = [ "0.0.0.0/0" ]
}

variable "web_asg_80_cidr_blocks" {
  description = "CIDR blocks to allow HTTP access"
  type        = list(string)
  default = [ "0.0.0.0/0" ]
}

variable "ami_id" {
  description = "The AMI ID to use for the instances"
  type        = string
  default = "ami-04b4f1a9cf54c11d0"
  
}
variable "key_name" {
  description = "The key name to use for the instances"
  type        = string
  default = "tryout"
  
}

variable "instance_type" {
  description = "The instance type to use for the instances"
  type        = string
  default = "t2.micro"
  
}

variable "min_size" {
  description = "The minimum number of instances"
  type        = number
  default = 1
  
}

variable "max_size" {
  description = "The maximum number of instances"
  type        = number
  default = 3
}
variable "desired_capacity" {
  description = "The desired number of instances"
  type        = number
  default = 2
  
}