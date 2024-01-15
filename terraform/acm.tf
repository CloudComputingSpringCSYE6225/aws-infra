# Find a certificate that is issued
data "aws_acm_certificate" "issued" {
  domain   = var.a_record_name
  statuses = ["ISSUED"]
}
