data "aws_ami" "custom_ami" {
  executable_users = ["self"]
  most_recent      = true
}

resource "aws_launch_template" "asg_launch_template" {
  depends_on = [
    aws_security_group.app_security_group
  ]
  name          = "asg_launch_config"
  image_id      = data.aws_ami.custom_ami.id
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data     = base64encode(data.template_file.userData.rendered)
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.app_security_group.id]
  }
  iam_instance_profile {
    name = aws_iam_instance_profile.EC2-CSYE6225_instance_profile.name
  }
  disable_api_termination = true
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = var.instance_volume_size
      volume_type = var.instance_volume_type
    }
  }
}