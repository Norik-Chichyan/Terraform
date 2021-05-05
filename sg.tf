resource "aws_security_group" "my-tf-ec2-sg" {
  name        = "allow http/https"
  description = "Allow http/https"
  
  dynamic "ingress" {
    for_each = ["80", "443", "22", "3306"]
    content {
      description = "allow http/https"
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
