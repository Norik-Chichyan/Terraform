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

resource "aws_instance" "wordpress-1" {
  ami           = "ami-042e8287309f5df03"
  instance_type = "t2.micro"
  #  security_groups = [aws_security_group.web-sg.name]
  key_name = "aws-key2"

  network_interface {
    network_interface_id = aws_network_interface.wordpress-1-int.id
    device_index         = 0
  }

  tags = {
    Name = "wordpress-1"
  }
}

resource "aws_instance" "wordpress-2" {
  ami           = "ami-042e8287309f5df03"
  instance_type = "t2.micro"
  #  security_groups = [aws_security_group.web-sg.name]
  key_name = "aws-key2"

  network_interface {
    network_interface_id = aws_network_interface.wordpress-2-int.id
    device_index         = 0
  }

  tags = {
    Name = "wordpress-2"
  }
}

resource "aws_instance" "bastion" {
  ami           = "ami-042e8287309f5df03"
  instance_type = "t2.micro"
  #  security_groups = [aws_security_group.bastion-sg.name]
  key_name = "aws-key2"

  network_interface {
    network_interface_id = aws_network_interface.bastion-int.id
    device_index         = 0
  }

  tags = {
    Name = "bastion"
  }

}

resource "local_file" "wordpress_config" {
  content = templatefile("wp-config-template",
    {
      db_name = aws_db_instance.mysql-rds.address
    }
  )
  depends_on = [
    aws_db_instance.mysql-rds
  ]
  filename = "roles/wordpress/templates/wp-config-template"

}

resource "local_file" "ssh_config" {
  content = templatefile("sshconfig.tmpl",
    {
      wp1-ip     = aws_instance.wordpress-1.private_ip
      wp2-ip     = aws_instance.wordpress-2.private_ip
      bastion-ip = aws_instance.bastion.public_ip
    }
  )
  filename = "config"

}

resource "null_resource" "cp_ssh_file" {
  provisioner "local-exec" {
    command = "cp config ~/.ssh/config"
  }

  depends_on = [
    aws_db_instance.mysql-rds,
    aws_instance.wordpress-1,
    aws_instance.wordpress-2,
    aws_instance.bastion
  ]
}

#resource "local_file" "ansible" {
#  content = templatefile("inventory.tmpl",
#  { 
#     wp1-ip       = aws_instance.wordpress-1.private_ip
#     wp2-ip       = aws_instance.wordpress-2.private_ip
#     bastion-ip   = aws_instance.bastion.public_ip
#  }
#  )
#  filename = "inventory"
#}

resource "null_resource" "ansible-run" {
  provisioner "local-exec" {
    command = "ansible-playbook -i inventory wordpress.yml"
  }

  depends_on = [
    null_resource.cp_ssh_file,
    aws_db_instance.mysql-rds,
    aws_instance.wordpress-1,
    aws_instance.wordpress-2,
    aws_instance.bastion
  ]

}

#output "wordpress" {
# value = aws_elb.wordpress-lb.public_dns
#}

