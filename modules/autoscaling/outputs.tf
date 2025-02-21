
output "web_asg_id" {
  description = "The ID of the web ASG"
  value       = aws_autoscaling_group.web_asg.id
  
}

output "web_url" {
  description = "The URL of the web instances"
  value       = aws_lb.web_alb.dns_name
}