# terraform_p1
Problem #1 (Terraform)

## Setup SSH Public Key to access the instance
1) Generate SSH keys in the local machine.
> * For MacOS or Linux: `$ ssh-keygen -t rsa -b 4096`
> * For Putty on Windows: Follow this link https://www.ssh.com/ssh/putty/windows/puttygen
2) (Only Applicable to MacOS or Linux) Run the `add_sshkey.sh` script to add the public SSH key in the instance_config.tf file.
> * ensure the ssh public key is stored in the default SSH directory `~/.ssh/`
> * ensure the add_sshkey.sh file is executable by executing `$ chmod +x add_sshkey.sh`
3) (For Putty on Windows) Copy and paste the SSH public key to the instance_config.tf file under the "public_sshkey" variable
> variable "public_sshkey" {
>   default = "ssh-rsa `your ssh key here`
> }

Pre-requisites:
AWS Cli must be installed on local machine. Refer to the link https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html for installation steps.

execute "$ aws configure" to setup AWS Access Key ID and Secret Access Key. Once it's done, verify the keys in ~/.aws/credentials on Linux and MacOS or %UserProfile%\.aws\credentials on a Windows system.

Assumption:
1. "Default" profile specified in AWS credentials file is used.
2. SSH public key is present in the machine that will be executing Terraform commands.
