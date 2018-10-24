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
            "Action": "ec2:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "elasticloadbalancing:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "cloudwatch:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "autoscaling:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "iam:CreateServiceLinkedRole",
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "iam:AWSServiceName": [
                        "autoscaling.amazonaws.com",
                        "ec2scheduled.amazonaws.com",
                        "elasticloadbalancing.amazonaws.com",
                        "spot.amazonaws.com",
                        "spotfleet.amazonaws.com"
                    ]
                }
            }
        }
  ]
}
EOF
}

resource "aws_iam_user_policy_attachment" "serhiy-attach" {
  user       = "${var.iam_username}"
  policy_arn = "${aws_iam_policy.serhiy_ec2.arn}"
}

resource "null_resource" "iam_delay" {
  depends_on = ["aws_iam_user_policy_attachment.serhiy-attach", "aws_iam_policy.serhiy_ec2"]
  provisioner "local-exec" {
    command = "sleep 5"
  }
}