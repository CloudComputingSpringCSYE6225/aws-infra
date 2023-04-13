resource "aws_db_parameter_group" "pg_parameter_group" {
  name        = "pg-14-parameter-group"
  family      = "postgres14"
  description = "Parameter Group for PostgreSQL 14"
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "main"
  subnet_ids = [for subnet in aws_subnet.private_subnets : subnet.id]

  tags = {
    Name = "DB subnet group"
  }
}

resource "aws_db_instance" "main" {

  engine                 = var.db_engine
  instance_class         = var.db_instance
  identifier             = var.db_instance_identifier
  db_name                = var.db_name
  username               = var.db_username
  multi_az               = var.db_multi_az
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  parameter_group_name   = aws_db_parameter_group.pg_parameter_group.name
  publicly_accessible    = false
  allocated_storage      = 10
  vpc_security_group_ids = [aws_security_group.db_security_group.id]
  skip_final_snapshot    = true

  # Enable encryption
  storage_encrypted = true
  kms_key_id        = aws_kms_key.rdsKey.arn
}