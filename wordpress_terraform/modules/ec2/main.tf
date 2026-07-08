data "aws_ami" "amazon_linux" {

  most_recent = true

  owners = ["137112412989"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


resource "aws_instance" "wordpress_1" {

  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  subnet_id = var.private_subnet_1_id

  vpc_security_group_ids = [
    var.security_group_id
  ]

  associate_public_ip_address = false

   user_data = templatefile("${path.module}/user_data.sh.tpl", {
    efs_dns_name = var.efs_dns_name
    rds_endpoint = var.rds_endpoint
    rds_username = var.rds_username
    rds_password = var.rds_password
    rds_name     = var.rds_name
  })

    key_name =aws_key_pair.deployer.key_name

    iam_instance_profile = aws_iam_instance_profile.ssm_profile.name
  

  tags = {
    Name = "wordpress-instance-1"
  }
}


resource "aws_instance" "wordpress_2" {

  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  subnet_id = var.private_subnet_2_id

  vpc_security_group_ids = [
    var.security_group_id
  ]

  associate_public_ip_address = false

   user_data = templatefile("${path.module}/user_data.sh.tpl", {
    efs_dns_name = var.efs_dns_name
    rds_endpoint = var.rds_endpoint
    rds_username = var.rds_username
    rds_password = var.rds_password
    rds_name     = var.rds_name
  })
  key_name =aws_key_pair.deployer.key_name
   
  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name


  tags = {
    Name = "wordpress-instance-2"
  }
}


resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key ="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDlaKlSnOeSi9xGt7Su8+IzJn8sAwv3EcjEMsJpIM835 aleem@192.168.1.17"
}

resource "aws_iam_role" "ssm_role" {

  name = "wordpress-ec2-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "ssm_policy" {

  role = aws_iam_role.ssm_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"

}


resource "aws_iam_instance_profile" "ssm_profile" {
  name = "wordpress-ec2-ssm-profile"
  role = aws_iam_role.ssm_role.name
}