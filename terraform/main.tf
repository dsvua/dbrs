# Configure the AWS Provider
provider "aws" {
//  access_key = "${var.aws_access_key}"
//  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_iam_policy" "serhiy_ec2" {
  name        = "serhiy_ec2_policy"
  path        = "/"
  description = "Policy to create and destroy EC2 instances"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1540365557121",
      "Action": [
        "ec2:RunInstances",
        "ec2:Describe*",
        "ec2:TerminateInstances",
        "ec2:AuthorizeSecurityGroupEgress",
        "ec2:AuthorizeSecurityGroupIngress",
        "ec2:DeleteSecurityGroup",
        "ec2:RevokeSecurityGroupEgress",
        "ec2:RevokeSecurityGroupIngress",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeSecurityGroupReferences",
        "ec2:DescribeStaleSecurityGroups",
        "ec2:DescribeVpcs",
        "ec2:CreateNatGateway",
        "ec2:CreateRoute",
        "ec2:CreateSubnet",
        "ec2:CreateVpc",
        "ec2:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_user_policy_attachment" "serhiy-attach" {
  user       = "${var.iam_username}"
  policy_arn = "${aws_iam_policy.serhiy_ec2.arn}"
}

