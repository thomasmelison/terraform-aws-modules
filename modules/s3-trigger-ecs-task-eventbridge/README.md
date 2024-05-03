# Trigger to ECS Task for S3 Event.

## What is this module?

This module provision a trigger for when an S3 event occur to trigger an ECS Task that that will run with environment variables related to the S3 event. For this module to work you need an S3 bucket, an ECS cluster with a Task Definition and a subnet to run this ECS Task.
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_s3_bucket_notification.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_notification) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ecs"></a> [ecs](#input\_ecs) | ECS task configuration including networking | <pre>object({<br>    cluster_arn           = string<br>    task_definition_arn   = string<br>    task_subnet_id        = list(string)<br>    is_task_subnet_public = bool<br>    container_name        = string<br>  })</pre> | n/a | yes |
| <a name="input_permissions"></a> [permissions](#input\_permissions) | IAM roles and policies for ECS invocation | <pre>object({<br>    invoke_ecs_role_prefix_name   = string<br>    invoke_ecs_policy_prefix_name = string<br>  })</pre> | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The AWS region where resources will be deployed | `string` | n/a | yes |
| <a name="input_rules_and_targets"></a> [rules\_and\_targets](#input\_rules\_and\_targets) | List of rules and corresponding targets configuration | <pre>list(object({<br><br>    prefix           = optional(string)<br>    suffix           = optional(string)<br>    bus_name         = optional(string)<br>    rule_name_prefix = optional(string)<br>    description      = optional(string)<br>    event_names      = optional(list(string))<br>  }))</pre> | `[]` | no |
| <a name="input_s3"></a> [s3](#input\_s3) | S3 bucket configuration | <pre>object({<br>    bucket_id   = string<br>    bucket_name = string<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudwatch_event_rule_id"></a> [cloudwatch\_event\_rule\_id](#output\_cloudwatch\_event\_rule\_id) | Id of the event rule that triggers the ECS Task. |
<!-- END_TF_DOCS -->