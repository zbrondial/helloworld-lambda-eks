#### Lambda for Hello world API

# A ClouwWatch log group must be created for the lambda function

resource "aws_cloudwatch_log_group" "apihw_log_group" {
  name = "/aws/lambda/${local.project_name}"
  tags = local.default_tags
}

# A dedicated iam role must be created for the lambda function

resource "aws_iam_role" "apihw_lambda_role" {
  name               = "apihw-lambda-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["lambda.amazonaws.com"]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# IAM Policy creation for CloudWatch Permision on Lambda's IAM role

resource "aws_iam_policy" "cw_policy" {
  name        = "${local.apihw_function}-cw-policy"
  description = "CloudWatch Logs permission for lambda IAM role"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "logs:CreateLogGroup",
            "Resource": "${local.cw_resource}:*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": [
                "${aws_cloudwatch_log_group.apihw_log_group.arn}:*"
            ]
        }
    ]
}
EOF
}

# Attaching the policy to the IAM role

resource "aws_iam_role_policy_attachment" "cw_policy_attachment" {
  role       = aws_iam_role.apihw_lambda_role.name
  policy_arn = aws_iam_policy.cw_policy.arn
}


# Lambda function for Hello World API


data "archive_file" "apihw_lambda_zip" {
  type        = "zip"
  source_file = "main.py"
  output_path = "function.zip"
}

resource "aws_lambda_function" "apihwlambda" {
  # provider      = aws.us-east-1
  function_name = local.apihw_function
  filename      = "function.zip"
  handler       = "main.main_handler"
  runtime       = "python3.9"
  publish       = "true" // Important!
  role          = aws_iam_role.apihw_lambda_role.arn
}