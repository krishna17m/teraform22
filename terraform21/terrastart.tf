provider "aws" {
  access_key = "AKIAJOIZJBN3C5YGBJCA"
  secret_key = "7eIO2rDHpunboGth85E/DVJ5Tpos/Vo9Sfdja61V"
  region     = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
}