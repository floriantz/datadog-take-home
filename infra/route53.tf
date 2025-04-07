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