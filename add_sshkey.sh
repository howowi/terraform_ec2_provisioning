#/bin/bash

## remove the public_sshkey variable first
sed '/variable "public*/,/}/d' instance_config.tf > instance_config_tmp.tf
mv instance_config_tmp.tf instance_config.tf

## store the public SSH key from the default directory to the instance_config.tf
public_key=$(cat ~/.ssh/id_rsa.pub)
cat <<EOT >> instance_config.tf
variable "public_sshkey" {
  default = "$public_key"
}
EOT
