output "iam_policy_name" {
  description = "name of Custom policy"
  value       = module.IAMRole.iam_policy_name
}

output "iam_role_name" {
  description = "name of Custom Role"
  value       = module.IAMRole.iam_role_name
}

output "iam_policy_arn" {
  description = "arn of Custom policy"
  value       = module.IAMRole.iam_policy_arn
}

output "iam_role_arn" {
  description = "arn of Custom Role"
  value       = module.IAMRole.iam_role_arn
}
