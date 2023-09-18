output "iam_policy_name" {
  description = "name of Created Custom policy"
  value       = aws_iam_policy.custom_policy.name
}

output "iam_role_name" {
  description = "name of Created Custom Role"
  value       = aws_iam_role.custom_role.name
}

output "iam_policy_arn" {
  description = "arn of Created Custom policy"
  value       = aws_iam_policy.custom_policy.arn
}

output "iam_role_arn" {
  description = "arn of Created Custom Role"
  value       = aws_iam_role.custom_role.arn
}
