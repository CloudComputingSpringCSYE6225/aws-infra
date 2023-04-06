resource "aws_cloudwatch_metric_alarm" "scaleUpAlarm" {
  alarm_name          = "ASG_Scale_Up"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 5

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.app_autoscaling_group.name
  }

  alarm_description = "Scale up if CPU > 5% for 1 minute"
  alarm_actions     = [aws_autoscaling_policy.scaleUpPolicy.arn]
}

resource "aws_cloudwatch_metric_alarm" "scaleDownAlarm" {
  alarm_name          = "ASG_Scale_Down"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 3

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.app_autoscaling_group.name
  }

  alarm_description = "Scale down if CPU < 3% for 1 minute"
  alarm_actions     = [aws_autoscaling_policy.scaleDownPolicy.arn]
}