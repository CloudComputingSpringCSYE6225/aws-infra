resource "aws_lb" "applicationLB" {
  name               = "Application-Load-Balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_security_group.id]
  subnets            = [for subnet in aws_subnet.public_subnets : subnet.id]
  tags = {
    webapp = "webappInstance"
  }
}

resource "aws_lb_target_group" "LBTargetGroup" {
  name       = "Load-Balancer-Target-Group"
  port       = 8080
  protocol   = "HTTP"
  vpc_id     = aws_vpc.vpc.id
  slow_start = 100
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200"
    path                = "/healthz"
  }
}

resource "aws_lb_listener" "LBListener" {
  load_balancer_arn = aws_lb.applicationLB.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = data.aws_acm_certificate.issued.arn
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.LBTargetGroup.arn
  }
}