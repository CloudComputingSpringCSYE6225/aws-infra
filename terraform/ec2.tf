# Instance profile to attach role to the EC2 instance
resource "aws_iam_instance_profile" "EC2-CSYE6225_instance_profile" {
  name = "EC2-CSYE6225_Role_Instance_profile"
  role = aws_iam_role.EC2-CSYE6225.name
}

resource "aws_instance" "ec2_instance" {
  depends_on = [
    aws_security_group.app_security_group
  ]
  ami                     = var.ami_id
  instance_type           = var.instance_type
  subnet_id               = aws_subnet.public_subnets[0].id
  vpc_security_group_ids  = [aws_security_group.app_security_group.id]
  disable_api_termination = true
  iam_instance_profile = aws_iam_instance_profile.EC2-CSYE6225_instance_profile.name
  root_block_device {
    volume_size = var.instance_volume_size
    volume_type = var.instance_volume_type
  }
  tags = {
    Name = "Webapp EC2 Instance"
  }
  user_data = <<EOF
    #!/bin/bash
    rm -f /home/ec2-user/webapp/.env
    touch /home/ec2-user/webapp/.env
    echo "AWS_BUCKET_NAME='${aws_s3_bucket.private_s3_bucket.id}'" >> /home/ec2-user/webapp/.env
    echo "DB_USER='${var.db_username}'" >> /home/ec2-user/webapp/.env
    echo "DB_PASSWORD='${var.db_password}'" >> /home/ec2-user/webapp/.env
    echo "DB_DATABASE='${var.db_name}'" >> /home/ec2-user/webapp/.env
    echo "DB_PORT=${var.db_port}" >> /home/ec2-user/webapp/.env
    echo "DB_HOST='${aws_db_instance.main.address}'" >> /home/ec2-user/webapp/.env
    sudo systemctl restart webapp.service

  EOF
}

# resource "null_resource" "reboot_instance" {

#   provisioner "local-exec" {
#     on_failure  = fail
#     interpreter = ["/bin/bash", "-c"]
#     command     = <<EOT
#         sleep 20
#         aws ec2 reboot-instances --instance-ids ${aws_instance.ec2_instance.id} --profile ${var.profile}
#      EOT
#   }
#   #   this setting will trigger script every time,change it something needed
#   triggers = {
#     always_run = "${timestamp()}"
#   }


# }
