# policy 생성
data "template_file" "custom_policy_json" {
  template = file(var.custom_policy_json_path)
}

resource "aws_iam_policy" "custom_policy" {
  name        = var.iam_policy_name
  description = var.policy_description
  policy      = data.template_file.custom_policy_json.rendered
}

# role 생성
data "template_file" "role_trust_policy" {
  template = file(var.role_trust_policy_json_path)
}

resource "aws_iam_role" "custom_role" {
  name               = var.iam_role_name
  description        = var.role_description
  assume_role_policy = data.template_file.role_trust_policy.rendered
}

# role policy attachment
resource "aws_iam_policy_attachment" "iam_policy_attachment" {
  name       = "attachment_name"
  policy_arn = aws_iam_policy.custom_policy.arn
  roles      = [aws_iam_role.custom_role.name]

  depends_on = [aws_iam_policy.custom_policy, aws_iam_role.custom_role]
}
