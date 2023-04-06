data "aws_route53_zone" "currentZone" {
  name = var.a_record_name
}

resource "aws_route53_record" "a_record" {
  zone_id = data.aws_route53_zone.currentZone.zone_id
  name    = var.a_record_name
  type    = "A"
  alias {
    evaluate_target_health = true
    name                   = aws_lb.applicationLB.dns_name
    zone_id                = aws_lb.applicationLB.zone_id
  }
}