variable "aws_region" {
  description = "The AWS region things are created in"
  default     = "eu-west-1"
}
variable "app_port" {
  description = "Port on which application is running"
  default     = 8080
}

variable "app_image" {
  description = "Image to run in ECS"
  default     = "619801971185.dkr.ecr.eu-west-1.amazonaws.com/ecs-flask-app:latest"
}

variable "log_group_name" {
  description = "Name of the log group name used by flask app"
  default     = "/ecs/flask_app"
}
variable "health_check_path" {
  description = "Http path for task health check"
  default     = "/health"
}
variable "certificate_arn" {
  description = "The ARN of the default SSL certificate for HTTPS listener"
  type        = string
  default     = "arn:aws:acm:us-east-1:619801971185:certificate/c9585748-3a0c-456a-9061-9969c7d3cdf5"
}
