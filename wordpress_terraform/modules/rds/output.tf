output "rds_endpoint" {
  value = aws_db_instance.default.endpoint
}

output "rds_id" {
  value = aws_db_instance.default.id
}


output "db_name" {
  value=aws_db_instance.default.db_name
}

output "db_username" {
  value = aws_db_instance.default.username
  
}

output "db_password" {
  value     = var.db_password
  sensitive = true
}

output "db_hostname" {
  value = aws_db_instance.default.address
  
}