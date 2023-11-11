terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.7.0"
    }
  }
  required_version = ">= 0.14.9"
}

# Load Balancer 생성
resource "aws_lb" "create_load_balancer" {
  name               = var.lb-name
  internal           = false
  security_groups    = var.security_groups
  load_balancer_type = var.lb-type
  subnets            = var.lb-vpc_subnet_ids

  enable_deletion_protection = false
}

# Target Group 생성
resource "aws_lb_target_group" "create_target_group" {
  name     = var.tg-name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = 80
    unhealthy_threshold = 2
    timeout             = 3
  }

  depends_on = [aws_lb.create_load_balancer]
}

# Target Group에 기존 인스턴스 등록, 없으면 반복문 실행 안됨
resource "aws_lb_target_group_attachment" "target_attachment" {
  for_each         = { for id in var.existing_instance_ids : id => id }
  target_group_arn = aws_lb_target_group.create_target_group.arn
  target_id        = each.value

  depends_on = [aws_lb_target_group.create_target_group]
}

# Load Balancer에 Target Group 등록
resource "aws_lb_listener" "example_listener" {
  load_balancer_arn = aws_lb.create_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.create_target_group.arn
  }

  depends_on = [aws_lb_target_group_attachment.target_attachment]
}
