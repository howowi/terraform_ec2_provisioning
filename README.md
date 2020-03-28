# Provision EC2 instance on AWS Using Terraform

## AWS CLI
1) AWS Cli is primarily used to interract with AWS to manage cloud resources but it also provides the utility to configure the access key to authenticate againts the IAM setup in AWS console which is important for the Terraform AWS provider to work.
2) Refer to the link https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html for installation steps.
3) Once AWS Cli is installed, run `$ aws configure` to setup AWS Access Key ID and Secret Access Key. Once it's done, verify the keys in `~/.aws/credentials` on Linux and MacOS or `%UserProfile%\.aws\credentials on a Windows system`.
```
[default]
aws_access_key_id = A**************X
aws_secret_access_key = P****************************y
```

## Setup SSH Public Key to access the EC2 instance
1) Before applying the Terraform configuration, EC2 keypair will need the SSH public key from the client to access the EC2 instance via SSH.
1) First, generate SSH keys in the local machine if it's not yet created.
  * For MacOS or Linux: `$ ssh-keygen -t rsa -b 4096`
  * For Putty on Windows: Follow this link https://www.ssh.com/ssh/putty/windows/puttygen
2) (**Only applicable to MacOS or Linux**) Run the `add_sshkey.sh` script to add the public SSH key in the instance_config.tf file.
  * ensure the ssh public key is stored in the default SSH directory `~/.ssh/`
  * ensure the add_sshkey.sh file is executable by executing `$ chmod +x add_sshkey.sh`
3) (**Only applicable Putty on Windows**) Copy and paste the SSH public key into the config_variable.tf file under the "public_sshkey" variable
```
variable "public_sshkey" {
   default = "ssh-rsa <your ssh key here>"
}
```
## Execute the Terraform Config
1) Variables of the EC2 and VPC configuration have been defined in config_variable.tf file as shown below is supported without modifying the main config file. 
* AWS region
* VPC CIDR
* Subnet CIDR
* OS image
* EC2 instance type 
* SSH public key (either manually key in or use the add_sshkey.sh script for MacOS and Linux machine)
3) After cloning the repo from Github, first, the terraform directory must be initialized by running `$ terraform init`.
2) Check that no typo or syntax error by running `$ terraform validate` and you should see
```
Success! The configuration is valid.
```
3) Then, run `terraform plan` to review the deployment. The output can be seen in terraform_plan_output.txt file.
4) To start the deployment, run `terraform apply`.
5) You will be prompted the message below and just type `yes` and press enter to continue.
```
Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes
```
6) Once the deployment is successfull, you will see the public IP address of the EC2 instance as seen below. The public IP address can be used to SSH to the EC2 instance via the local machine.
```
Apply complete! Resources: 7 added, 0 changed, 0 destroyed.

Outputs:

ec2_devops_public_ip = 54.169.210.56
```
7) SSH to the EC2 instance `$ ssh ubuntu@54.169.210.56`
