# Créer le Load Balancer
resource "aws_lb" "app_lb" {
  name  = var.LbName
  internal = false
  load_balancer_type = "application"
  subnets = aws_subnet.public[*].id

  enable_deletion_protection = false

  tags = {
    Name = var.LbName
  }
}

# Créer le groupe cible
resource "aws_lb_target_group" "app_tg" {
  name  = var.TgName
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.main.id

  health_check {
    interval = var.HealthCheckInterval
    path = var.HealthCheckPath
    protocol  = "HTTP"
    timeout = var.HealthCheckTimeout
    healthy_threshold   = var.HealthCheckHealthyThreshold
    unhealthy_threshold = var.HealthCheckUnhealthyThreshold
  }

  tags = {
    Name = var.TgName
  }
}

# Créer un listener HTTPS pour le Load Balancer
resource "aws_lb_listener" "app_listener_https" {
  load_balancer_arn = aws_lb.app_lb.arn
  port  = var.ListenerPort
  protocol  = var.ListenerProtocol

  ssl_policy  = "ELBSecurityPolicy-2016-08"
  certificate_arn = var.CertificateArn

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

# Créer un listener HTTP pour rediriger le trafic HTTP vers HTTPS
resource "aws_lb_listener" "app_listener_http" {
  count = var.RedirectHttpToHttps ? 1 : 0
  
  load_balancer_arn = aws_lb.app_lb.arn
  port  = 80
  protocol  = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      protocol = "HTTPS"
      port  = "443"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_security_group" "app_lb_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port  = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "app-lb-sg"
  }
}


