# Task Definition

## What is this module?

This module provision a simple Task Definition at ECS to run one or more containers. You can define the attributes like memory, cpu an environment variables with for this task definition and for each container at the Task definition.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_ecs_task_definition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_role.execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.task_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_containers"></a> [containers](#input\_containers) | List of containers at the task definition | <pre>list(object({<br>    name      : string<br>    image     : string<br>    cpu       : number<br>    memory    : number<br>    environment : list(object({<br>      name  : string<br>      value : string<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | Number of CPU units used by the Task Definition. | `number` | `null` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | Amount of memory used by the task definition. | `number` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | Region of the log group of the container. | `string` | n/a | yes |
| <a name="input_task_definition_name"></a> [task\_definition\_name](#input\_task\_definition\_name) | Name for the task definition (attribute family at the AWS Task Definition Resource) | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecs_task_definition_arn"></a> [ecs\_task\_definition\_arn](#output\_ecs\_task\_definition\_arn) | ARN of the task definition that has been provisioned. |
| <a name="output_execution_role_id"></a> [execution\_role\_id](#output\_execution\_role\_id) | Role ID of the execution role that is used by the task. |
| <a name="output_task_role_id"></a> [task\_role\_id](#output\_task\_role\_id) | Role ID of the task role used by the task. These is the role that will be used when the container is running. |
<!-- END_TF_DOCS -->