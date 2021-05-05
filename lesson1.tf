terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "allow_in_out_sg" {
    name        = "allow_in_access"
    description = "Allow  inbound and outbound traffic"
  
    ingress {
      description      = "from any to 80 port"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]    
    }

    ingress {
      description      = "from any to 22 port"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }
    
    egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]

    }
}

resource "local_file" "inventory" {
 content = templatefile("WebServer.host",
 {
  public_ip = aws_instance.my-tf-ec2.public_ip
 }
 )
 filename = "inventory"
}

resource "aws_instance" "my-tf-ec2" {
  ami           = "ami-042e8287309f5df03"
  instance_type = "t2.micro"
  security_groups = ["allow_in_access"]
  key_name = "aws-key2"
  provisioner "local-exec" {
     command = "ansible-playbook  -i inventory  wordpress.yml"
   
  }
}
