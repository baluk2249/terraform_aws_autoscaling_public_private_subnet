output "instances" {
  description = "The IDs of the instances"
  value       = aws_instance.web.*.id
  
}

output "web_asg_id" {
  description = "The ID of the web ASG"
  value       = aws_autoscaling_group.web.id
  
}

output "web_url" {
  description = "The URL of the web instances"
  value       = aws_lb.web.dns_name
}