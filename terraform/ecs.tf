resource "aws_ecs_cluster" "cluster-ecs-flask" {
  name = "FlaskAppCluster"
}

resource "aws_launch_configuration" "ecs" {
  name                        = var.ecs_cluster_name
  image_id                    = var.amis
  instance_type               = var.instance_type
  security_groups             = [aws_security_group.ecs-flask_app.id]
  iam_instance_profile        = aws_iam_instance_profile.ecs.name
  #key_name                    = aws_key_pair.production.key_name
  associate_public_ip_address = true
}
resource "aws_ecs_task_definition" "flask_app" {
  family                   = "flask_app"
  container_definitions    = templatefile("${path.module}/task-definitions/flask_app.json.tpl", {
                                         app_image      = var.app_image,
                                         app_port       = var.app_port,
                                         aws_region     = var.aws_region,
                                         log_group_name = var.log_group_name
                                         })
}

resource "aws_ecs_service" "cluster-ecs-flask" {
  name            = "${var.ecs_cluster_name}-service"
  cluster         = aws_ecs_cluster.cluster-ecs-flask.id
  task_definition = aws_ecs_task_definition.flask_app.arn
  iam_role        = aws_iam_role.ecs-service-role.arn
  desired_count   = var.app_count
  depends_on      = [aws_alb_listener.ecs-alb-http-listener, aws_iam_role_policy.ecs-service-role-policy]

  load_balancer {
    target_group_arn = aws_alb_target_group.default-target-group.arn
    container_name   = "ecs-flask-app"
    container_port   = 8080
}  
}