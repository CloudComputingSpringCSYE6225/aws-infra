resource "aws_autoscaling_group" "app_autoscaling_group" {
  name                = "csye6225-asg-spring2023"
  default_cooldown    = 60
  min_size            = 1
  max_size            = 3
  desired_capacity    = 1
  vpc_zone_identifier = [for subnet in aws_subnet.public_subnets : subnet.id]
  launch_template {
    id      = aws_launch_template.asg_launch_template.id
    version = "$Latest"
  }
  health_check_type = "EC2"
  #  termination_policies = ["OldestInstance", "Default"]
  tag {
    key                 = "webapp"
    value               = "webappInstance"
    propagate_at_launch = true
  }
  target_group_arns = [aws_lb_target_group.LBTargetGroup.arn]
}