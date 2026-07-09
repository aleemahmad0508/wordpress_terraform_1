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


resource "aws_launch_template" "wordpress_lt" {

  name_prefix = "wordpress-lt-"

  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.deployer.key_name

  iam_instance_profile {
    name = aws_iam_instance_profile.ssm_profile.name
  }

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [var.security_group_id]
  }

  user_data = base64encode(templatefile("${path.module}/user_data.sh.tpl", {
    efs_dns_name = var.efs_dns_name
    rds_endpoint = var.rds_endpoint
    rds_username = var.rds_username
    rds_password = var.rds_password
    rds_name     = var.rds_name
  }))

  tag_specifications {

    resource_type = "instance"

    tags = {
      Name = "wordpress-asg-instance"
    }
  }

  update_default_version = true
}



resource "aws_autoscaling_group" "wordpress_asg" {

  name = "wordpress-asg"

  desired_capacity = 2
  min_size         = 2
  max_size         = 4

  health_check_type         = "ELB"
  health_check_grace_period = 300

  vpc_zone_identifier = [
    var.private_subnet_1_id,
    var.private_subnet_2_id
  ]

  target_group_arns = [
    var.target_group_arn
  ]

  launch_template {

    id      = aws_launch_template.wordpress_lt.id
    version = "$Latest"
  }

  tag {

    key                 = "Name"
    value               = "wordpress-asg-instance"
    propagate_at_launch = true
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