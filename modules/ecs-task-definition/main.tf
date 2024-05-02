

locals {
  container_name = "serverlessland-dump-env-vars"
}
### ECS Cluster ###
resource "aws_ecs_cluster" "serverlessland-ecs-test-cluster" {
  name = "serverlessland-ecs-test-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

### ECS Task Definition ###
resource "aws_ecs_task_definition" "serverlessland-ecs-task-definition" {
  family                   = "serverlessland-ecs-task-definition"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  task_role_arn            = aws_iam_role.serverlessland-ecs-task-role.arn
  execution_role_arn       = aws_iam_role.serverlessland-ecs-task-execution-role.arn
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "${local.container_name}",
    "image": "${var.image_url}",
    "cpu": 1024,
    "memory": 2048,
    "essential": true,
    "logConfiguration": {
          "logDriver": "awslogs",
          "options": {
            "awslogs-group": "${aws_cloudwatch_log_group.serverlessland-cw-log-grp-dump-env-vars.name}",
            "awslogs-region": "${var.region}",
            "awslogs-stream-prefix": "ecs"
          }
    }
  }
]
TASK_DEFINITION

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}

### CloudWatch Log Group ###
resource "aws_cloudwatch_log_group" "serverlessland-cw-log-grp-dump-env-vars" {
  name = "/ecs/serverlessland-dump-env-vars"
}

### ECS Task Execution Role ###
resource "aws_iam_role" "serverlessland-ecs-task-execution-role" {
  name                = "serverlessland-ecs-task-execution-role"
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
}

### Create a policy to access S3 buckets ###
resource "aws_iam_policy" "ecs_s3_access_policy" {
  name = "serverlessland_ecs_s3_access_policy" #TODO: CREATE A Module to permit access from a TASK to the Bucket!!!!
  policy = jsonencode({

    Version : "2012-10-17",
    Statement : [
      {
        Sid : "",
        Action : [
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Effect : "Allow",
        Resource : [
          "arn:aws:s3:::${var.bucket_name}",
          "arn:aws:s3:::${var.bucket_name}/*"
        ]
      }
    ]
  })
}

### ECS Task Role ###
resource "aws_iam_role" "serverlessland-ecs-task-role" {
  name = "serverlessland-ecs-task-role"
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
  aws_iam_policy.ecs_s3_access_policy.arn]
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}