provider "aws" {
  region = "ap-northeast-2"
}

module "IAMRole" {
  source = "./modules/aws-iam-role"

  iam_policy_name             = "test-policy"
  iam_role_name               = "test-role"
  custom_policy_json_path     = "/home/ec2-user/iam/test-policy.json"
  role_trust_policy_json_path = "/home/ec2-user/iam/test-role-trust.json"

  # Optional
  policy_description = "my-policy-description"
  # Optional
  role_description = "my-role-description"
}
