variable "ami_id" {
  description = "The AMI ID to use for the launch template"

  
}

variable "instance_type" {
  description = "The instance type to use for the launch template"
  
}

variable "key_name" {
  description = "The key name to use for the launch template"
  
}

variable "web_private_asg_id" {
  description = "The ID of the web private ASG security group"
  type        = string
}

variable "web_asg_min_size" {
  description = "The minimum size of the web ASG"
  type        = number
  
}
variable "web_asg_max_size" {
  description = "The maximum size of the web ASG"
  type        = number
  
}
variable "web_asg_desired_capacity" {
  description = "The desired capacity of the web ASG"
  type        = number
  
}
variable "public_subnet_ids" {
  description = "The IDs of the subnets for the private ASG"
  type        = list(string)
  
}
variable "web_asg_subnet_ids" {
  description = "The IDs of the subnets for the web ASG"
  type        = list(string)
}

variable "vpc_id" {
  description = "value of the vpc_id"
  type        = string
}