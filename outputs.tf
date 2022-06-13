
output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
output "acm_validations" { value = aws_acm_certificate.globalCert.domain_validation_options }
output "global_acm_arn" { value = aws_acm_certificate.globalCert.arn }
output "eks_cluster_arn" { value = module.eks.cluster_arn }
output "eks_cluster_endpoint" { value = module.eks.cluster_endpoint }
output "eks_cluster_id" { value = module.eks.cluster_id }
output "eks_cluster_oidc" { value = module.eks.cluster_oidc_issuer_url }
output "eks_cluster_oidc_prov" { value = module.eks.oidc_provider }
output "eks_cluster_oidc_prov_arn" { value = module.eks.oidc_provider_arn }
# output "web" { value = aws_security_group.web.id }
# output "elbsg" { value = aws_security_group.elb.id }
# output "elb" { value = aws_lb.this.dns_name }
# output "elb_key" { value = local.lb_cf_only > 0 ? [random_string.elb_key.result] : [] }
# output "lb_logs_bucket_domain_name" { value = aws_s3_bucket.lb_logs.bucket_domain_name }
# output "lb_logs_bucket_arn" { value = aws_s3_bucket.lb_logs.arn }
# output "listener" { value = aws_lb_listener.port443.arn }
output "vpc_id" {
  description = "VPC ID of the Main Site"
  value       = module.vpc.vpc_id
}

# output "db_subnet_group" {
#   description = "DB Subnet Group Name"
#   value       = module.vpc.database_subnet_group
# }

output "private_subnets" {
  description = "Private Subnets"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "Public Subnets"
  value       = module.vpc.public_subnets
}

# output "database_subnets" {
#   description = "Database Subnets"
#   value       = module.vpc.database_subnets
# }

# output "management_subnet" {
#   description = "Management Subnet"
#   value       = aws_subnet.management.id
# }

output "nat_public_ips" { value = module.vpc.nat_public_ips }

# output "blue_target_groups" {
#   value = { for key in keys(aws_lb_target_group.blue) : key => {
#     name = aws_lb_target_group.blue[key].name
#     arn  = aws_lb_target_group.blue[key].arn
#   } }
# }
# output "green_target_groups" {
#   value = { for key in keys(aws_lb_target_group.green) : key => {
#     name = aws_lb_target_group.green[key].name
#     arn  = aws_lb_target_group.green[key].arn
#   } }
# }

# ## ECS Outputs
# output "ecs_cluster_name" { value = aws_ecs_cluster.cluster.name }
# output "ecs_cluster_arn" { value = aws_ecs_cluster.cluster.arn }
# output "ecs_task_definition" {
#   value = { for key in keys(aws_ecs_task_definition.this) : key => {
#     arn       = aws_ecs_task_definition.this[key].arn
#     family    = aws_ecs_task_definition.this[key].family
#     image_url = module.ecr[key].url
#     ecr_name  = "${key}-${local.env}"
#     }
#   }
# }

# output "web_iam" { value = aws_iam_role.web.arn }

# output "server_settings_bucket_arn" { value = aws_s3_bucket.server_settings.arn }

# output "server_settings_bucket_id" { value = aws_s3_bucket.server_settings.id }

# output "cloudfront" {
#   value = {
#     domain_name = aws_cloudfront_distribution.main.domain_name
#     hosted_zone = aws_cloudfront_distribution.main.hosted_zone_id
#   }
# }

# output "main_arn" { value = aws_wafv2_web_acl.main.arn }