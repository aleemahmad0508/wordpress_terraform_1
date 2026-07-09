module "networks" {
  source = "./modules/networks"

  vpc_cidr              = var.vpc_cidr
  public_subnet_1_cidr  = var.public_subnet_1_cidr
  public_subnet_2_cidr  = var.public_subnet_2_cidr
  private_subnet_1_cidr = var.private_subnet_1_cidr
  private_subnet_2_cidr = var.private_subnet_2_cidr

  az1 = var.az1
  az2 = var.az2

  project_name = var.project_name
  environment  = var.environment
}

module "security" {
  source = "./modules/security"

  vpc_id = module.networks.vpc_id
}

module "rds" {
  source = "./modules/rds"

  vpc_id              = module.networks.vpc_id
  private_subnet_1_id = module.networks.private_subnet_1_id
  private_subnet_2_id = module.networks.private_subnet_2_id

  db_name           = var.db_name
  db_username       = var.db_username
  db_password       = var.db_password
  db_instance_class = var.db_instance_class

  security_group_id = module.security.rds_sg_id
}

module "ec2" {
  source = "./modules/ec2"

  vpc_id             = module.networks.vpc_id
  private_subnet_1_id  = module.networks.private_subnet_1_id
  private_subnet_2_id  = module.networks.private_subnet_2_id

  security_group_id = module.security.ec2_sg_id

  target_group_arn = module.alb.target_group_arn

  

  efs_dns_name = module.efs.efs_dns_name
  rds_endpoint = module.rds.rds_endpoint
  rds_username = var.db_username
  rds_password = var.db_password
  rds_name     = var.db_name
}

module "alb" {

  source = "./modules/alb"

  vpc_id = module.networks.vpc_id

  public_subnet_1_id = module.networks.public_subnet_1_id
  public_subnet_2_id = module.networks.public_subnet_2_id


  alb_security_group_id = module.security.alb_sg_id


}

module "efs" {
    source ="./modules/efs"
    private_subnet_1_id = module.networks.private_subnet_1_id
    private_subnet_2_id = module.networks.private_subnet_2_id   
    security_group_id = module.security.efs_sg_id
  
}



terraform {
  backend "s3" {
    bucket         = "terraform-state-6bucket"
    key            = "wordpress_terraform/terraform.tfstate"
    region         = "us-east-1"
    use_lockfile = true
    encrypt        = true
  }
}