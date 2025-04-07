locals {
    domain_name = "floriantz.com"
}

data "aws_route53_zone" "floriantz" {
  name         = "${local.domain_name}."
}

resource "aws_route53_record" "datadog_take_home_subdomain_record" {
  zone_id = data.aws_route53_zone.floriantz.id
  name    = "datadog-take-home.${local.domain_name}"
  type    = "A"
  alias {
    name                   = aws_s3_bucket_website_configuration.dd_take_home_site_website_configuration.website_domain
    zone_id                = aws_s3_bucket.dd_take_home_site.hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_acm_certificate" "floriantz_domain_certificate" {
  domain_name       = local.domain_name
  subject_alternative_names = [ "*.${local.domain_name}" ]
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "floriantz_cname_records" {
  for_each = {
    for dvo in aws_acm_certificate.floriantz_domain_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.floriantz.id
}

resource "aws_acm_certificate_validation" "floriantz_domain_certificate_validation" {
  certificate_arn         = aws_acm_certificate.floriantz_domain_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.floriantz_cname_records : record.fqdn]
}