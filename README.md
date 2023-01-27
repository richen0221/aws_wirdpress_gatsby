# Readme

It will build:
- 1 VPC with 2 public subnets and 2 private subnets.
- 2 security groups for admin and internet connection.
- 1 instance with docker to run the wordpress service.
- 1 instance will docker for gatsby.
- import the public key for instance to ssh.

## Usage
1. change the var.tf make sure your ip and ssh key are right.
2. make sure the providers.tf setting is corrected.
3. execute `terraform init` then `terraform apply`
