output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
  
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = module.vpc.public_subnet_ids
  
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = module.vpc.private_subnet_ids
 
}

output "web_private_asg_id" {
  description = "The ID of the security group for the web instances"
  value       = module.vpc.web_private_asg_id
  
}

output "instances" {
  description = "The IDs of the instances"
  value       = module.autoscaling.instances
  
}
output "web_asg_id" {
  description = "The ID of the web ASG"
  value       = module.autoscaling.web_asg_id
  
}

output "web_url" {
  description = "The URL of the web instances"
  value       = module.autoscaling.web_url
  
}