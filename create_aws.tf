provider "aws" {
  profile    = "default"
  region     = "ap-southeast-1"
}

resource "aws_instance" "ec2_devops" {
  ami           = "ami-04a2d6660f1296314"
  instance_type = "t2.micro"
}
