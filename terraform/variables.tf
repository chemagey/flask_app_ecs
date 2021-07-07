variable "aws_region" {
  description = "The AWS region things are created in"
  default     = "eu-west-1"
}
variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  default     = "cluster-ecs-flask"
}
variable "app_port" {
  description = "Port on which application is running"
  default     = 8080
}

variable "app_image" {
  description = "Image to run in ECS"
  default     = "619801971185.dkr.ecr.eu-west-1.amazonaws.com/ecs-flask-app:latest"
}
variable "app_count" {
  description = "Number of Docker containers to run"
  default     = 2
}
variable "log_group_name" {
  description = "Name of the log group name used by flask app"
  default     = "/ecs/flask_app"
}
variable "health_check_path" {
  description = "Health check path for the default target group"
  default     = "/ping/"
}
variable "certificate_arn" {
  description = "The ARN of the default SSL certificate for HTTPS listener"
  type        = string
  default     = "arn:aws:acm:us-east-1:619801971185:certificate/c9585748-3a0c-456a-9061-9969c7d3cdf5"
}
variable "log_retention_in_days" {
  description = "The retention in days of the log in cloudwatch"
  default     = 30
}
variable "amis" {
  description = "Which AMI to spawn."
  default     = "ami-0f89681a05a3a9de7"
}
variable "instance_type" {
  default = "t2.micro"
}
variable "autoscale_min" {
  description = "Minimum autoscale (number of EC2)"
  default     = "1"
}
variable "autoscale_max" {
  description = "Maximum autoscale (number of EC2)"
  default     = "10"
}
variable "autoscale_desired" {
  description = "Desired autoscale (number of EC2)"
  default     = "4"
}