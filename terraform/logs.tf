resource "aws_cloudwatch_log_group" "flask_app" {
  name = var.log_group_name
  retention_in_days = var.log_retention_in_days
}