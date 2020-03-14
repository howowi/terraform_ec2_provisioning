provider "aws" {
  skip_requesting_account_id = true
  profile    = "default"
  version    = "~> 2.0"
  region     = "ap-southeast-1"
}

resource "aws_instance" "ec2_devops" {
  ami           = "ami-04a2d6660f1296314"
  instance_type = "t2.micro"
}
