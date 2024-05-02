
output "ecs_cluster_arn" {
  value = aws_ecs_cluster.serverlessland-ecs-test-cluster.arn
}

output "ecs_task_definition_arn" {
  value = aws_ecs_task_definition.serverlessland-ecs-task-definition.arn
}

output "container_name" {
  value = local.container_name
}