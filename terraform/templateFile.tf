data "template_file" "userData" {
  template = file("./userData.sh")
  vars = {
    AWS_BUCKET_NAME = aws_s3_bucket.private_s3_bucket.id
    DB_USER         = var.db_username
    DB_PASSWORD     = var.db_password
    DB_DATABASE     = var.db_name
    DB_PORT         = var.db_port
    DB_HOST         = aws_db_instance.main.address
  }
}