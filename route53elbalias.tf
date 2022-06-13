resource "aws_route53_record" "cdn_alias" {
  name    = local.domain
  type    = "A"
  zone_id = local.dns_zone_id
  alias {
    name                   = local.eks_elb_arecord
    zone_id                = local.eks_elb_hosted_zone_id
    evaluate_target_health = false
  }
}