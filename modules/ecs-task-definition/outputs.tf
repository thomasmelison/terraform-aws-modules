
output "ecs_task_definition_arn" {
  value = aws_ecs_task_definition.this.arn
  description = "ARN of the task definition that has been provisioned."
}
