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

resource "aws_instance" "my-tf-ec2" {
  ami             = "ami-042e8287309f5df03"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.my-tf-ec2-sg.name]
  key_name        = "aws-key2"
}

resource "local_file" "ansible" {
  content = templatefile("inventory.tmpl",
    {
      instance_ip = aws_instance.my-tf-ec2.public_ip
    }
  )
  filename = "inventory"
}

resource "null_resource" "ansible_run" {
  provisioner "local-exec" {
    command = "ansible-playbook -i inventory --user ubuntu --private-key /home/norik/.ssh/aws-key2.pem wordpress.yml"
  }

  depends_on = [local_file.ansible]
}

output "wordpress" {
  value = aws_instance.my-tf-ec2.public_dns
}

