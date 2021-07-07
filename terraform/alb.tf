resource "aws_alb" "alb-flask_app" {
  name               = "ecs-flask-alb"
  load_balancer_type = "application"
  internal           = false
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_1a.id, aws_subnet.public_1b.id]
}

resource "aws_alb_target_group" "default-target-group" {
  name     = "ecs-flask-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc-flask_app.id

  health_check {
    path                = var.health_check_path
    port                = "traffic-port"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 2
    interval            = 5
    matcher             = "200"
  }
}


resource "aws_alb_listener" "ecs-alb-http-listener" {
  load_balancer_arn = aws_alb.alb-flask_app.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn
  depends_on        = [aws_alb_target_group.default-target-group]

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.default-target-group.arn
  }
}