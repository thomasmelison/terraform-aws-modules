
output "cloudwatch_event_rule_id" {
  description = "Id of the event rule that triggers the ECS Task."
  value       = [for _, event_rule in aws_cloudwatch_event_rule.this : event_rule.id]
}
