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
1) Generate SSH keys in the local machine.
> * For MacOS or Linux: `$ ssh-keygen -t rsa -b 4096`
> * For Putty on Windows: Follow this link https://www.ssh.com/ssh/putty/windows/puttygen
2) (Only Applicable to MacOS or Linux) Run the `add_sshkey.sh` script to add the public SSH key in the instance_config.tf file.
> * ensure the ssh public key is stored in the default SSH directory `~/.ssh/`
> * ensure the add_sshkey.sh file is executable by executing `$ chmod +x add_sshkey.sh`
3) (For Putty on Windows) Copy and paste the SSH public key to the instance_config.tf file under the "public_sshkey" variable
```
variable "public_sshkey" {
   default = "ssh-rsa `your ssh key here`
}
```
