resource "aws_iam_role" "vpcflowlogsrole" {
  name = "${join("-", list(lower(var.tenant), "vpcflowlogsrole", lower(var.environment)))}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "vpcflowlog_policy" {
  name = "${join("-", list(lower(var.tenant), "vpcflowlog_policy", lower(var.environment)))}"
  role = "${aws_iam_role.vpcflowlogsrole.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}