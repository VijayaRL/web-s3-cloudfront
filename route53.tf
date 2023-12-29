# Fetch the AWS Route 53 hosted zone ID for the specified domain name.
data "aws_route53_zone" "public_zone_id" {
  name         = var.domain_name
  private_zone = false
}

# Request an AWS ACM (Amazon Certificate Manager) certificate for the specified domain name.
resource "aws_acm_certificate" "certificate" {
  provider          = aws.acm_certificate
  domain_name       = var.domain_name
  validation_method = "DNS"
}

# Create Route 53 DNS records for certificate validation.
resource "aws_route53_record" "certificate_validation" {
  for_each = {
    for domain in aws_acm_certificate.certificate.domain_validation_options :
    domain.domain_name => {
      name   = domain.resource_record_name
      record = domain.resource_record_value
      type   = domain.resource_record_type
    }
  }
  name    = each.value.name
  records = [each.value.record]
  ttl     = 60
  type    = each.value.type
  zone_id = data.aws_route53_zone.public_zone_id.zone_id
}

# Create a Route 53 DNS record to associate the domain with an AWS CloudFront distribution.
resource "aws_route53_record" "websiteurl" {
  name    = var.domain_name
  type    = "A"
  zone_id = data.aws_route53_zone.public_zone_id.zone_id
  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = true
  }
}
