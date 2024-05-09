

variable "s3" {
  type = object({
    bucket_id   = string
    bucket_name = string
  })
  description = "S3 bucket configuration"
}

variable "ecs" {
  type = object({
    cluster_arn           = string
    task_definition_arn   = string
    task_subnet_id        = list(string)
    is_task_subnet_public = bool
    container_name        = string
  })
  description = "ECS task configuration including networking"
}

variable "permissions" {
  type = object({
    invoke_ecs_role_prefix_name   = string
    invoke_ecs_policy_prefix_name = string
  })
  description = "IAM roles and policies for ECS invocation"
}

variable "region" {
  description = "The AWS region where resources will be deployed"
  type        = string
}

variable "rules_and_targets" {
  description = "List of rules and corresponding targets configuration"
  type = list(object({

    prefix           = optional(string)
    suffix           = optional(string)
    bus_name         = optional(string)
    rule_name_prefix = optional(string)
    description      = optional(string)
    event_names      = optional(list(string))
  }))
  default = []
}

