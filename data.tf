data "terraform_remote_state" "tfstate" {
  backend   = "s3"
  workspace = terraform.workspace
  config = {
    bucket  = local.state_bucket
    key     = "terraform-state/terraform.tfstate"
    region  = "ap-southeast-1"
    profile = "default"
  }
}