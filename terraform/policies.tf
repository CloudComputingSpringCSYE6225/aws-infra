resource "aws_iam_policy" "WebAppS3" {
  name = "WebAppS3"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject",
          #          "s3:PutObjectAcl",
          #          "s3:GetObjectAcl"
        ],
        Effect = "Allow",
        Resource = [
          "arn:aws:s3:::${aws_s3_bucket.private_s3_bucket.id}",
          "arn:aws:s3:::${aws_s3_bucket.private_s3_bucket.id}/*"
        ]
      }
    ]
  })
}

resource "aws_autoscaling_policy" "scaleUpPolicy" {
  name                    = "Up policy"
  policy_type             = "SimpleScaling"
  scaling_adjustment      = 1
  adjustment_type         = "ChangeInCapacity"
  cooldown                = 60
  autoscaling_group_name  = aws_autoscaling_group.app_autoscaling_group.name
  metric_aggregation_type = "Average"
}

resource "aws_autoscaling_policy" "scaleDownPolicy" {
  name                    = "Down policy"
  policy_type             = "SimpleScaling"
  scaling_adjustment      = -1
  adjustment_type         = "ChangeInCapacity"
  cooldown                = 60
  autoscaling_group_name  = aws_autoscaling_group.app_autoscaling_group.name
  metric_aggregation_type = "Average"

}