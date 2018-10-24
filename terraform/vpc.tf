resource "aws_vpc" "serhiy" {
//  depends_on = ["aws_iam_user_policy_attachment.serhiy-attach", "aws_iam_policy.serhiy_ec2"]
  depends_on = ["null_resource.iam_delay"]
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "serhiy" {
  depends_on = ["null_resource.iam_delay"]
  vpc_id     = "${aws_vpc.serhiy.id}"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags {
    Name = "Serhiy"
  }
}

resource "aws_internet_gateway" "serhiy" {
  vpc_id = "${aws_vpc.serhiy.id}"

  tags {
    Name = "Serhiy"
  }
}

resource "aws_route" "serhiy" {
  depends_on = ["null_resource.iam_delay"]
  route_table_id         = "${aws_vpc.serhiy.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.serhiy.id}"
}

resource "aws_route_table_association" "serhiy" {
  depends_on = ["null_resource.iam_delay"]
  subnet_id = "${aws_subnet.serhiy.id}"
  route_table_id = "${aws_vpc.serhiy.main_route_table_id}"
}

resource "aws_security_group" "allow_8888" {
  depends_on = ["null_resource.iam_delay"]
  name        = "allow_8888"
  description = "Allow inbound traffic on port 8888"
  vpc_id      = "${aws_vpc.serhiy.id}"

  ingress {
    from_port   = 8888
    to_port     = 8888
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

//  ingress {
//    from_port   = 0
//    to_port     = 22
//    protocol    = "tcp"
//    cidr_blocks = ["24.191.208.31/32"]
//  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
