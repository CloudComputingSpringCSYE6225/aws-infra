resource "aws_instance" "my_ec2_instance" {
  depends_on = [
    aws_security_group.app_security_group
  ]
  ami                     = var.ami_id
  instance_type           = var.instance_type
  subnet_id               = aws_subnet.public_subnets[0].id
  vpc_security_group_ids  = [aws_security_group.app_security_group.id]
  disable_api_termination = true
  root_block_device {
    volume_size = var.instance_volume_size
    volume_type = var.instance_volume_type
  }
  tags = {
    Name = "Webapp EC2 Instance"
  }
}