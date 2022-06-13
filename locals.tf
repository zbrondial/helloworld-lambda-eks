locals {

  # account_id = data.aws_caller_identity.current.account_id
  aws_region = "ap-southeast-1"
  env        = terraform.workspace

  project_name = "apihelloworld"

  domain_name = "zi-zd.com"

  domain = local._domain[local.env]
  _domain = {
    dev  = "sayhello.zi-zd.com"
    prod = "helloworld.zi-zd.com"
  }

  state_bucket = local._state_bucket[terraform.workspace]
  _state_bucket = {
    dev  = "apihw-infra-tfstate-dev"
    prod = "apihw-infra-tfstate-prod"
  }

  dynamodb_table = "apihw-infra-state-lock-dynamo"
  _dynamodb_table = {
    dev  = "apihw-infra-state-lock-dynamo"
    prod = "apihw-infra-state-lock-dynamo-prod"
  }

  dns_zone_id = "Z0232203BKYT2PCD6FBG"

  default_tags = {
    ProvisionedBy = "Dial Bron"
    env           = local.env
  }

  ##Lamdba Variables
  cw_resource    = substr(aws_cloudwatch_log_group.apihw_log_group.arn, 0, 34)
  apihw_function = "apihwLambda"


  acm_certificate = aws_acm_certificate.globalCert.arn

  #### VPC Variables ####

  name     = "hw"
  vpc_name = "${local.name}-${terraform.workspace}"

  vpc_vars = {
    dev = {
      cidr = "10.10.0.0/16"

      azs = ["${local.aws_region}c", "${local.aws_region}a"]

      private_subnets  = []
      public_subnets   = ["10.10.101.0/24", "10.10.102.0/24"]
      database_subnets = ["10.10.1.0/24"]

      enable_nat_gateway     = false
      single_nat_gateway     = false
      one_nat_gateway_per_az = false
      reuse_nat_ips          = false
      external_nat_ip_ids    = []

      create_database_subnet_group       = false
      create_database_subnet_route_table = false

      management_az     = "${local.aws_region}c"
      management_subnet = "10.10.99.0/24"
    }

    prod = {
      cidr = "10.100.0.0/16"

      azs = ["${local.aws_region}c", "${local.aws_region}a"]

      private_subnets  = ["10.100.11.0/24", "10.100.12.0/24"]
      public_subnets   = ["10.100.101.0/24", "10.100.102.0/24"]
      database_subnets = []

      enable_nat_gateway     = true
      single_nat_gateway     = true
      one_nat_gateway_per_az = false
      reuse_nat_ips          = false
      external_nat_ip_ids    = []

      create_database_subnet_group       = false
      create_database_subnet_route_table = false

      management_az     = "${local.aws_region}c"
      management_subnet = "10.100.99.0/24"
    }
  }

  default_network_acl_ingress = [
    {
      rule_no    = 100
      action     = "allow"
      from_port  = 0
      to_port    = 0
      protocol   = "-1"
      cidr_block = "0.0.0.0/0"
    },
  ]

  default_network_acl_egress = [{
    rule_no    = 100
    action     = "allow"
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    cidr_block = "0.0.0.0/0"
  }]

  local_tags = merge(local.default_tags, {
    project_name = local.project_name
  })

  ## EKS Variables
  k8s_cluster_name       = "hw-eks"
  cluster_name           = "hw-eks"
  eks_elb_arecord        = "a2d6c943b87554b48a2c7b1158d4d556-103598869.ap-southeast-1.elb.amazonaws.com"
  eks_elb_hosted_zone_id = "Z1LMS91P8CMLE5"

}