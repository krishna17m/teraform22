# configure providers as aws
provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "teraforminstance" {
  ami                         = "ami-f2d3638a"                      # us-west-2
  instance_type               = "t2.micro"
  count                       = 1
  subnet_id                   = "${aws_subnet.subtera.id}"
  associate_public_ip_address = true
  key_name                    = "${aws_key_pair.sasi-key.key_name}"

  tags {
    Name = "teraforminstance"
  }
}

# key pair assosiation
resource "aws_key_pair" "sasi-key" {
key_name   = "sasipub"
public_key = "${file("sasipub.pem")}" # location of pub key
}

# vpc and CIDR
resource "aws_vpc" "vpctera" {
  cidr_block = "11.11.0.0/16"

  tags {
    Name = "vpctera"
  }
}

# subnet and CIDR
resource "aws_subnet" "subtera" {
  vpc_id     = "${aws_vpc.vpctera.id}"
  cidr_block = "11.11.1.0/24"

  tags {
    Name = "subtera"
  }
}

# internet gateway
resource "aws_internet_gateway" "gwtera" {
  vpc_id = "${aws_vpc.vpctera.id}"

  tags {
    Name = "igwteraform"
  }
}

# rout table
resource "aws_route_table" "routtera" {
  vpc_id = "${aws_vpc.vpctera.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gwtera.id}"
  }

  tags {
    Name = "terarout"
  }
}

# Route table attaching
resource "aws_route_table_association" "a" {
  subnet_id      = "${aws_subnet.subtera.id}"
  route_table_id = "${aws_route_table.routtera.id}"
}
