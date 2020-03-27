#/bin/bash

## remove the public_sshkey variable first
sed '/variable "public*/,/}/d' 

public_key=$(cat ~/.ssh/id_rsa.pub)

cat <<EOT >> test.yml
variable "public_sshkey" {
  default = "$public_key"
}
EOT
