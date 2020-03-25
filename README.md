# terraform_p1
Problem #1 (Terraform)

1) Modify the instance_config.tf file.
2) Copy and paste the SSH public key to the instance_config.tf file.
2) Execute $ terraform apply.

Pre-requisites:
AWS Cli must be installed on local machine. Refer to the link https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html for installation steps.

execute "$ aws configure" to setup AWS Access Key ID and Secret Access Key. Once it's done, verify the keys in ~/.aws/credentials on Linux and MacOS or %UserProfile%\.aws\credentials on a Windows system.

Assumption:
1. "Default" profile specified in AWS credentials file is used.
2. SSH public key is present in the machine that will be executing Terraform commands.
