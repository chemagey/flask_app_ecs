resource "aws_security_group" "ecs-flask_app" {
  name        = "allow_http"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.vpc-flask_app.id

    ingress {
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    ingress {
        from_port       = 443
        to_port         = 443
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    egress {
        from_port       = 0
        to_port         = 65535
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }

}

resource "aws_security_group" "alb_sg" {
  name = "alb-group"
  description = "control access to the application load balancer"
  vpc_id = aws_vpc.vpc-flask_app.id

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
}

resource "aws_iam_role" "ecs_task_role" {
  name               = "flaskEcsPolicies"
  description        = "Allows ECS tasks to call AWS services on your behalf"
  assume_role_policy = file("${path.module}/policies/ecs-assume-role-policy.json")
}


resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "ECSTaskExecution"
  description        = "Allows ECS tasks to call AWS services on your behalf"
  assume_role_policy = file("${path.module}/policies/ecs-assume-role-policy.json")
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


