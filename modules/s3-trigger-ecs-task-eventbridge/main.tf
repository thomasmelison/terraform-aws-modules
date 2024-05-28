locals {
  rules_and_targets_formatted = [for rule in var.rules_and_targets : {
    prefix           = rule.prefix != null ? rule.prefix : ""
    suffix           = rule.suffix != null ? rule.suffix : "*"
    bus_name         = rule.bus_name != null ? rule.bus_name : "default"
    rule_name_prefix = rule.rule_name_prefix
    description      = rule.description
    event_names      = rule.event_names != null ? rule.event_names : ["*"]
  }]
}


resource "aws_s3_bucket_notification" "this" {
  bucket      = var.s3.bucket_id
  eventbridge = true
}

resource "aws_iam_role" "this" {
  name                = var.permissions.invoke_ecs_role_prefix_name
  managed_policy_arns = [aws_iam_policy.this.arn]

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "events.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "this" {
  name = var.permissions.invoke_ecs_policy_prefix_name

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "ecs:RunTask"
        ],
        "Resource" : [
          "${var.ecs.task_definition_arn}:*",
          "${var.ecs.task_definition_arn}"
        ],
        "Condition" : {
          "ArnLike" : {
            "ecs:cluster" : "${var.ecs.cluster_arn}"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : "iam:PassRole",
        "Resource" : [
          "*"
        ],
        "Condition" : {
          "StringLike" : {
            "iam:PassedToService" : "ecs-tasks.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_cloudwatch_event_rule" "this" {
  count = length(local.rules_and_targets_formatted)


  name_prefix    = local.rules_and_targets_formatted[count.index].rule_name_prefix
  description    = local.rules_and_targets_formatted[count.index].description
  event_bus_name = local.rules_and_targets_formatted[count.index].bus_name

  event_pattern = <<EOF
  {
    "source": ["aws.s3"],
    "detail-type": ["Object Created"],
    "detail": {
      "bucket": {
        "name": ["${var.s3.bucket_name}"]
      },
      "object": {
        "key": [
          {"prefix": "${local.rules_and_targets_formatted[count.index].prefix}"},
          {"suffix": "${local.rules_and_targets_formatted[count.index].suffix}"}
          ]
      },
      "eventName": ["PutObject"]
    }
  }
  EOF
}

resource "aws_cloudwatch_event_target" "this" {
  count = length(local.rules_and_targets_formatted)

  rule           = aws_cloudwatch_event_rule.this[count.index].name
  arn            = var.ecs.cluster_arn
  role_arn       = aws_iam_role.this.arn
  event_bus_name = local.rules_and_targets_formatted[count.index].bus_name

  ecs_target {
    task_count          = 1
    task_definition_arn = var.ecs.task_definition_arn
    launch_type         = "FARGATE"

    network_configuration {
      subnets          = var.ecs.task_subnet_id
      assign_public_ip = var.ecs.is_task_subnet_public
    }
  }

  input_transformer {
    input_paths = {
      bucket_name = "$.detail.bucket.name",
      object_key  = "$.detail.object.key"
    }


    input_template = <<EOF
    {
      "containerOverrides": [
        {
          "name": "${var.ecs.container_name}",
          "environment" : [
            {
              "name" : "BUCKET_NAME",
              "value" : <bucket_name>
            },
            {
              "name" : "OBJECT_KEY",
              "value" : <object_key>
            }
          ]
        }
      ]
    }
    EOF

  }
}

