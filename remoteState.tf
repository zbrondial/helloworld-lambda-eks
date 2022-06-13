# create a S3 bucket for remotely storing state file
resource "aws_s3_bucket" "states" {
  bucket = local.state_bucket
  # acl    = "private"

  # server_side_encryption_configuration {
  #   rule {
  #     apply_server_side_encryption_by_default {
  #       sse_algorithm = "AES256"
  #     }
  #   }
  # }

  tags = local.default_tags
}


# create a DynamoDB table for locking the state file
resource "aws_dynamodb_table" "dynamodb_state_lock" {
  name           = local.dynamodb_table
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = local.default_tags
}