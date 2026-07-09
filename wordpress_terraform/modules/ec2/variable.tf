variable "vpc_id" {
  description = "VPC ID"
  type        = string
}



variable "security_group_id" {
  description = "EC2 security group ID"
  type        = string
}


variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}


variable "efs_dns_name" {
  description = "DNS name for the EC2 instance"
  type        = string
}


variable "private_subnet_1_id" {
  description = "Private Subnet 1 ID for EC2"
  type        = string
}

variable "private_subnet_2_id" {
  description = "Private Subnet 2 ID for EC2"
  type        = string
}

variable "target_group_arn" {
  type = string
}

variable "rds_name" {
  
}

variable "rds_username" {
  
}

variable "rds_endpoint" {
  
}

variable "rds_password" {
  
}