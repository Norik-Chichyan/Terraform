resource "aws_network_interface" "bastion-int" {
  subnet_id       = aws_subnet.public.id
  security_groups = [aws_security_group.bastion-sg.id]

  tags = {
    Name = "bastion server interface"
  }
}

resource "aws_network_interface" "wordpress-1-int" {
  subnet_id       = aws_subnet.public.id
  security_groups = [aws_security_group.web-sg.id]

  tags = {
    Name = "wordpress-1 network interface"
  }
}

resource "aws_network_interface" "wordpress-2-int" {
  subnet_id       = aws_subnet.public.id
  security_groups = [aws_security_group.web-sg.id]

  tags = {
    Name = "wordpress-2 network interface"
  }
}
