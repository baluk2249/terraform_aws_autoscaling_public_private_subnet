resource "aws_launch_template" "web_launch_template" {
  name_prefix   = "web-launch-template"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data     = base64encode(file("${path.module}/userdata.sh"))
 
  
  network_interfaces {
    security_groups = [var.web_private_asg_id]
  }
  
  monitoring     {
    enabled = true
  }
 
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "web-instance"
    }
  }
  
}


resource "aws_autoscaling_group" "web_asg" {
  name                      = "web-asg"
  launch_template {
    id      = aws_launch_template.web_launch_template.id
    version = "$Latest"
  }
  min_size                  = var.web_asg_min_size
  max_size                  = var.web_asg_max_size
  desired_capacity          = var.web_asg_desired_capacity
  vpc_zone_identifier       = var.web_asg_subnet_ids
  health_check_type         = "ELB"
  health_check_grace_period = 300
  termination_policies      = ["OldestInstance"]
  target_group_arns = [ aws_lb_target_group.web_itg_demo.arn ]
  tag {
    key                 = "Name"
    value               = "web-instance"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "scale_up_policy" {
  name                   = "scale-up-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.web_asg.name
  
}

resource "aws_autoscaling_policy" "scale_down_policy" {
  name                   = "scale-down-policy"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.web_asg.name
  
}

resource "aws_lb_target_group" "web_itg_demo" {
  name    = "web-itg-demo"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

}

resource "aws_lb" "web_alb" {
  name = "web-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [var.web_private_asg_id]
  subnets = var.public_subnet_ids
  enable_deletion_protection = true

  tags = {
    name = "web-alb"
  }
}

resource "aws_lb_listener" "web_listener" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_itg_demo.arn
  }
}