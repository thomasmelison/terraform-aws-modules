
output "ecs_task_definition_arn" {
  value = aws_ecs_task_definition.this.arn
  description = "ARN of the task definition that has been provisioned."
}

output "execution_role_id" {
  value = aws_iam_role.execution_role.id
  description = "Role ID of the execution role that is used by the task."
}

output "task_role_id" {
  value = aws_iam_role.task_role.id
  description = "Role ID of the task role used by the task. These is the role that will be used when the container is running."
}