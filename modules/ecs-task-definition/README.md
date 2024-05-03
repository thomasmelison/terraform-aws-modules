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
| [aws_cloudwatch_log_group.serverlessland-cw-log-grp-dump-env-vars](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_ecs_cluster.serverlessland-ecs-test-cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_task_definition.serverlessland-ecs-task-definition](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_policy.ecs_s3_access_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.serverlessland-ecs-task-execution-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.serverlessland-ecs-task-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | n/a | `any` | n/a | yes |
| <a name="input_image_url"></a> [image\_url](#input\_image\_url) | n/a | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_name"></a> [container\_name](#output\_container\_name) | n/a |
| <a name="output_ecs_cluster_arn"></a> [ecs\_cluster\_arn](#output\_ecs\_cluster\_arn) | n/a |
| <a name="output_ecs_task_definition_arn"></a> [ecs\_task\_definition\_arn](#output\_ecs\_task\_definition\_arn) | n/a |
<!-- END_TF_DOCS -->