variable "vpc_id" {
  description = "VPC ID"
  type        = string
}


variable "private_subnet_1_id" {
  description = "Private subnet 1 ID"
  type        = string
}


variable "private_subnet_2_id" {
  description = "Private subnet 2 ID"
  type        = string
}


variable "db_name" {
  description = "Database name"
  type        = string
}


variable "db_username" {
  description = "Database username"
  type        = string
}


variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}


variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}


variable "security_group_id" {
  description = "RDS security group ID"
  type        = string
}