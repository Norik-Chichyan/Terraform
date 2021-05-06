resource "aws_db_instance" "mysql-rds" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t2.micro"
  name                 = "wordpress_db"
  username             = "wordpress_user"
  password             = "my_password"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  vpc_security_group_ids = [ aws_security_group.db-sg.id ]
  db_subnet_group_name = aws_db_subnet_group.rds.name

}
