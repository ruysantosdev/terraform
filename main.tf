# Configure the AWS Provider
provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}

resource "aws_instance" "dev" {
  count         = 3
  ami           = "ami-0ac80df6eff0e70b5"
  instance_type = "t2.micro"
  key_name      = "terraform-pub"
  tags = {
    Name = "dev${count.index}"
  }
}

resource "aws_security_group" "acesso_ssh" {
  name        = "acesso_ssh"
  description = "Permite acesso SSH em instancias EC2"

  ingress {
    description = "SSH para EC2"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    // IP de saída usei o whats is my ip, como é dinamico precisa mudar a cada
    // conexão
    cidr_blocks = ["187.101.239.138/32"]
  }

  tags = {
    Name = "permite_ssh"
  }
}
