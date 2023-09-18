# 요약

### 간단한 단일 정책을 생성하고 연결된 역할을 생성한다.

- - -

# Example Usage

### main.tf
``` hcl
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

```

### outputs.tf
``` hcl 
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

```

- - -

# Argument Reference
|Argument|Description|Option|
|:--|:--|:--:|
|iam_policy_name                |생성할 정책 이름 | Required
|iam_role_name                  |생성할 역할 이름 | Required
|custom_policy_json_path        |정책 정의 파일의 경로 (json) | Required
|role_trust_policy_json_path    |역할의 신뢰관계 정의 파일의 경로 (json) | Required
|policy_description             |정책 설명 | Optional
|role_description               |역할 설명 | Optional 


- - -

# Attribute Reference
|Argument|Description|Value|
|:--|:--|:--|
|iam_policy_name   | 정책 이름 | module.<module 이름>.iam_policy_name
|iam_role_name     | 역할 이름 | module.<module 이름>.iam_role_name
|iam_policy_arn    | 정책 arn | module.<module 이름>.iam_policy_arn
|iam_role_arn      | 역할 arn | module.<module 이름>.iam_role_arn

- - -

# Import

repository의 modules 디렉토리를 통째로 원하는 VM에 넣는다. 

본인의 main.tf파일에서 위 예시를 확인하여 module을 사용한다.

#### Example
``` 
Terraform Dictionary Tree
├ main.tf (your code)
├ outputs.tf (your code)
├ variables.tf (your code)
└ modules 
  └ nat-instance
  └ others
  └ ...
```