# Create a new instance of the latest Ubuntu 14.04 on an
# t2.micro node with an AWS Tag naming it "HelloWorld"
provider "aws" {
  region = "us-west-2"
}

resource "aws_vpc" "myvpc"{

cidr= "10.20.0.0/16"
tags {
Name = "myvpc"
}


resoure "aws_subnet"  "subnet-1"{
cidr="10.20.1.0/24"
vpc_id="${aws_vpc.myvpc_id}"
}
}


data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  subnet_id="${aws_subnet.subnet-1.id}"

  tags {
    Name = "HelloWorld"
  }
}
