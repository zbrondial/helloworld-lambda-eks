#######################################################
######### ACM Cert Creation for zi-zd.com ##########
#######################################################

resource "aws_acm_certificate" "globalCert" {
  domain_name               = local.domain_name
  validation_method         = "DNS"
  provider                  = aws.us-east-1
  subject_alternative_names = ["*.zi-zd.com"]
  tags                      = local.default_tags
}

resource "aws_acm_certificate" "localCert" {
  domain_name               = local.domain_name
  validation_method         = "DNS"
  provider                  = aws
  subject_alternative_names = ["*.zi-zd.com"]
  tags                      = local.default_tags
}

# module "acm_request_certificate" {
#   source                            = "cloudposse/acm-request-certificate/aws"
#   domain_name                       = local.domain_name
#   process_domain_validation_options = true
#   ttl                               = "300"
#   subject_alternative_names         = ["*.zi-zd.com","dev.helloword.zi-zd.com","helloworld.zi-zd.com"]
#   tags                              = local.default_tags
# }

