variable "aws_region" {
    description = "The AWS region to deploy resources in"
    type        = string
    default     = "us-east-1"
  
}

variable "project_name" {
    description = "The name of the project"
    type        = string
    default     = "wordpress"
}

variable "environment" {
    description = "The environment for the deployment"
    type        = string
    default     = "dev"
}



variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
  default = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
  default = "10.0.2.0/24"
}

variable "private_subnet_1_cidr" {
  default = "10.0.3.0/24"
}

variable "private_subnet_2_cidr" {
  default = "10.0.4.0/24"
}

variable "az1" {
  default = "us-east-1a"
}

variable "az2" {
  default = "us-east-1b"
}


variable "db_name" {
  default = "wordpressdb"
}

variable "db_username" {
  default = "admin"
}

variable "db_password" {
  default = "aleem123"
}

variable "db_instance_class" {
  default = "db.t3.micro"
}



# Testing GitHub Actions

