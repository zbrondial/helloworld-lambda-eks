provider "aws" {
  region  = "ap-southeast-1"
  profile = "default"
}

provider "aws" {
  region = "us-east-1"
  alias  = "us-east-1"
}

terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "apihw-infra-tfstate-dev"
    region         = "ap-southeast-1"
    dynamodb_table = "apihw-infra-state-lock-dynamo"
    key            = "terraform-state/terraform.tfstate"
  }
}

data "aws_caller_identity" "current" {}
