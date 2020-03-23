variable "region" {
  default = "ap-southeast-1"
}

variable "cidr" {
  default = "192.168.0.0/16"
}

provider "aws" {
  region     = var.region
  version    = "~> 2.0"
}

#create Network

resource "aws_vpc" "vpc_devops" {
  cidr_block = var.cidr
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.vpc_devops.id}"
}

resource "aws_subnet" "sub_public_devops" {
  vpc_id     = "${aws_vpc.vpc_devops.id}"
  cidr_block = "192.168.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_security_group" "sg_devops" {
  name        = "sg_devops"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = "${aws_vpc.vpc_devops.id}"

  ingress {
    description = "HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_devops" {
  ami           = "ami-04a2d6660f1296314"
  instance_type = "t2.micro"

  depends_on = ["aws_internet_gateway.gw"]
}
