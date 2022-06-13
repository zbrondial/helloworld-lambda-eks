# Hello World Lambda API and Flask Webapp running behind AWS EKS

Terraform codes for deploying a Python Lambda API and the AWS EKS platform for running a Flask Web Application.

## System Architecture

![Say Hello Architecture](/assets/sayhello_app_arch.drawio.png)

## Procedures

1. Clone Git repository to get the files

```
git clone git@github.com:zbrondial/helloworld-lambda-eks.git
cd helloworld-lambda-eks
```

2. Update provider.tf for your AWS credential profile. This can be checked on your ~/.aws/credentials file

3. Still on provider.tf, comment out the terraform block for now. We have to create the S3 bucket and DynamoDB Table first.

```
# terraform {
#   backend "s3" {
#     encrypt        = true
#     bucket         = "apihw-infra-tfstate-dev"
#     region         = "ap-southeast-1"
#     dynamodb_table = "apihw-infra-state-lock-dynamo"
#     key            = "terraform-state/terraform.tfstate"
#   }
# }
```

4. Update locals.tf with the appropriate values

5. Deploy the s3 bucket and dynamodb table for remote statefile storage and management. We will also create a separate terraform workspace for dev and production environment. On this coding task, I've used the "dev" workspace.

```
terraform init
terraform workspace new dev
terraform workspace new prod
terraform workspace select dev
terraform apply -target aws_s3_bucket.states apihw-infra-tfstate-dev
terraform apply -target aws_dynamodb_table.dynamodb_state_lock apihw-infra-state-lock-dynamo
```

6. Migrate the locally stored terraform.tfstate to S3 backend. Edit again provider.tf, uncomment the terraform block and execute this command.

```
terraform init -reconfigure
```

7. Before running plan and apply, make sure that you are on the "dev" workspace.

```
terraform workspace list
terraform init
terraform plan
terraform apply
```

## Testing and Deploying the Flask Webapp in Kubernetes and AWS EKS

Please access the below repository for the procedure

- https://github.com/zbrondial/helloworld-apirunner
