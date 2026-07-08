resource "aws_lb" "this" {
  name               = "wordpress-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    var.alb_security_group_id
  ]

  subnets = [
    var.public_subnet_1_id,
    var.public_subnet_2_id
  ]

  tags = {
    Name = "wordpress-alb"
  }
}


resource "aws_lb_target_group" "this" {

  name        = "wordpress-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"

  vpc_id = var.vpc_id


  health_check {

    enabled             = true
    path                = "/"
    protocol            = "HTTP"

    interval            = 30
    timeout             = 5

    healthy_threshold   = 2
    unhealthy_threshold = 2

    matcher = "200-303"
  }


  tags = {
    Name = "wordpress-tg"
  }
}


# Attach EC2 Instance 1 to Target Group
resource "aws_lb_target_group_attachment" "ec2_1" {

  target_group_arn = aws_lb_target_group.this.arn

  target_id = var.ec2_instance_1_id

  port = 80
}


# Attach EC2 Instance 2 to Target Group
resource "aws_lb_target_group_attachment" "ec2_2" {

  target_group_arn = aws_lb_target_group.this.arn

  target_id = var.ec2_instance_2_id

  port = 80
}



resource "aws_lb_listener" "this" {

  load_balancer_arn = aws_lb.this.arn

  port     = 80
  protocol = "HTTP"


  default_action {

    type = "forward"

    target_group_arn = aws_lb_target_group.this.arn
  }
}