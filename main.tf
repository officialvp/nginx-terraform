provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "main" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"
}

resource "aws_security_group" "nginx_web" {
  name = "nginx_web"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "nginx_web" {
  ami = "ami-0144a5a84f5699847"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.nginx_web.id]
  subnet_id = aws_subnet.main.id
  
}

