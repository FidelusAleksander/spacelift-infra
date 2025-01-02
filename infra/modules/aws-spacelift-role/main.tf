resource "aws_iam_role" "this" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::324880187172:root"
        }
        Action = "sts:AssumeRole"
        Condition = {
          StringLike = {
            "sts:ExternalId" = "${var.spacelift_account_id}@*"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = toset(var.spacelift_role_policy_arns)

  role       = aws_iam_role.this.name
  policy_arn = each.value
}
