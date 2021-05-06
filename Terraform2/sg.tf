resource "aws_security_group" "web-sg" {
  name        = "allow http/https/ssh"
  description = "Allow http/https/ssh"
  vpc_id      = aws_vpc.my-vpc.id
  
  dynamic "ingress" {
    for_each = ["80", "443", "22"]
    content {
      description = "allow http/ssh"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group" "lb_sg" {
  name        = "allow http to lb"
  description = "Allow http inbound traffic to lb"
  vpc_id      = aws_vpc.my-vpc.id

  dynamic "ingress" {
    for_each = ["80", "443"]
    content {
      description = "allow http and https from public"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  
  }

  
}

resource "aws_security_group" "bastion-sg" {
  name        = "ssh to bastion"
  description = "Allow SSH to inside"
  vpc_id      = aws_vpc.my-vpc.id

  ingress {
    description = "SSH from world"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

}

resource "aws_security_group" "db-sg" {
  name        = "allow to db"
  description = "allow to database"
  vpc_id      = aws_vpc.my-vpc.id

  ingress {
    description = "allow to database"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.10.10.0/24"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}
