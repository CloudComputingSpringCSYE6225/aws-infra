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
          "s3:PutObjectAcl",
          "s3:GetObjectAcl",
          "s3:ListBucket"
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