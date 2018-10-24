resource "aws_vpc" "serhiy" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "serhiy" {
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
  route_table_id         = "${aws_vpc.serhiy.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.serhiy.id}"
}

resource "aws_route_table_association" "public_subnet_eu_west_1a_association" {
  subnet_id = "${aws_subnet.serhiy.id}"
  route_table_id = "${aws_vpc.serhiy.main_route_table_id}"
}

resource "aws_security_group" "allow_8888" {
  name        = "allow_8888"
  description = "Allow inbound traffic on port 8888"
  vpc_id      = "${aws_vpc.serhiy.id}"

  ingress {
    from_port   = 0
    to_port     = 8888
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}