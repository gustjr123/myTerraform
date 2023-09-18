# 요약

IAM 역할을 생성하기 위한 Terraform, 정책 또한 함께 생성한다.

- - -

# Argument Reference
## Required

**1. iam_policy_name - string**

    생성할 IAM 정책의 이름

**2. iam_role_name - string**

    생성할 IAM 역할의 이름

**3. custom_policy_json_path - string**

    생성할 정책을 정의한 json파일의 경로

**4. role_trust_policy_json_path - string**

    생성할 역할의 신뢰 관계를 정의한 json파일의 경로

## Optional

**5. policy_description - string**

    AWS IAM policy description

    default : User Custom IAM Created

**6. role_description - string**

    AWS IAM role description

    default : User Custom IAM Created

- - -

# Attribute Reference

- iam_policy_name = name of Created Custom policy
- iam_role_name = name of Created Custom Role
- iam_policy_arn = arn of Created Custom policy
- iam_role_arn = arn of Created Custom Role
