resource "aws_s3_bucket" "private_s3_bucket" {
  # Use bucket prefix for unique name everytime
  bucket_prefix = "${var.profile}-reb-"
  force_destroy = true
}

resource "aws_s3_bucket_lifecycle_configuration" "life_cycle_config" {
  bucket = aws_s3_bucket.private_s3_bucket.id

  rule {
    id = "transition"
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption_config" {
  bucket = aws_s3_bucket.private_s3_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.private_s3_bucket.id
  acl    = "private"
}