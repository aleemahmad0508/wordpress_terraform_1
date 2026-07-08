resource "aws_db_subnet_group" "this" {
  name = "wordpress-db-subnet-group"

  subnet_ids = [
    var.private_subnet_1_id,
    var.private_subnet_2_id
  ]

  tags = {
    Name = "WordPress DB Subnet Group"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage      = 20
  db_name                = var.db_name
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = var.db_instance_class

  username               = var.db_username
  password               = var.db_password

  parameter_group_name   = "default.mysql8.0"

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [var.security_group_id]

  publicly_accessible    = false
  skip_final_snapshot    = true

  tags = {
    Name = "wordpress-rds"
  }
}