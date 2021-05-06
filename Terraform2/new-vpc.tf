resource "aws_vpc" "my-vpc" {
  cidr_block = "10.10.0.0/16"
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.10.10.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "load_balancer"
  }
}

resource "aws_subnet" "db" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.10.20.0/24"

  tags = {
    Name = "rds"
  }
}

resource "aws_internet_gateway" "web_igw" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = "igw"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.web_igw.id
  }
  tags = {
    Name = "public route table"
  }
}


resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_db_subnet_group" "rds" {
  subnet_ids = [ aws_subnet.db.id, aws_subnet.public.id ]
  
}
