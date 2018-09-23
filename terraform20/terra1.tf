provider "aws"{
    region="ap-south-1"   
}

variable "region"{
type = "string"
default ="ap-south-1"
description = "Chose region in which resources are provisioned"
}


resource "aws_vpc" "jobassist_vpc" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    
    
    tags {
        Name = "jobassist_vpc"
        Location = "Bangalore"
        
}
}
resource "aws_subnet" "webservers"{
    vpc_id      = "$"
cidr_block="10.2.0.1/24"
vpc_id="${aws_vpc.main.id}"
tags{
    Name="subnet1"
}
}