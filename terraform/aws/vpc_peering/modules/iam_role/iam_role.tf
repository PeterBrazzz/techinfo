resource "aws_iam_role" "this" {
  name = "${var.prefix}-role"

  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  tags = merge(
    var.tags_iam_role,
    {
      Name = "${var.prefix}-role"
    },
  )
}

resource "aws_iam_policy" "this" {
  name   = "${var.prefix}-policy"
  policy = data.aws_iam_policy_document.policy_for_role.json
  tags = merge(
    var.tags_policy,
    {
      Name = "${var.prefix}-policy"
    },
  )
}

resource "aws_iam_role_policy_attachment" "SSM" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "this" {
  name = "${var.prefix}-profile"
  role = aws_iam_role.this.name
  tags = merge(
    var.tags_instance_profile,
    {
      Name = "${var.prefix}-profile"
    },
  )
}
