#/bin/bash

## remove the public_sshkey variable first
sed '/variable "public*/,/}/d' config_variable.tf > config_variable_tmp.tf
mv config_variable_tmp.tf config_variable.tf

## store the public SSH key from the default directory to the instance_config.tf
public_key=$(cat ~/.ssh/id_rsa.pub)
cat <<EOT >> config_variable.tf
variable "public_sshkey" {
  default = "$public_key"
}
EOT
