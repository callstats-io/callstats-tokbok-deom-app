resource "aws_vpc" "main" {
  cidr_block = "172.30.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  assign_generated_ipv6_cidr_block = "true"
}

resource "aws_subnet" "main-public-0" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "172.30.0.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1b"
  ipv6_cidr_block = "${cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 1)}"
  assign_ipv6_address_on_creation = "true"
}

resource "aws_subnet" "main-public-1" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "172.30.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1c"
  ipv6_cidr_block = "${cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 2)}"
  assign_ipv6_address_on_creation = "true"
}

resource "aws_subnet" "main-public-2" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "172.30.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1d"
  ipv6_cidr_block = "${cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 3)}"
  assign_ipv6_address_on_creation = "true"
}

resource "aws_subnet" "main-public-3" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "172.30.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1e"
  ipv6_cidr_block = "${cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 4)}"
  assign_ipv6_address_on_creation = "true"
}

# Internet GW

resource "aws_internet_gateway" "main-gw" {
  vpc_id = "${aws_vpc.main.id}"
}

resource "aws_route_table" "main-public" {
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main-gw.id}"
  }

  # route {
  #   cidr_block = "::/0" # or a new ipv6_cidr_block param
  #   gateway_id = "${aws_internet_gateway.main-gw.id}"
  # }
}

resource "aws_route_table_association" "main-public-0-a" {
  subnet_id = "${aws_subnet.main-public-0.id}"
  route_table_id = "${aws_route_table.main-public.id}"
}
resource "aws_route_table_association" "main-public-1-a" {
  subnet_id = "${aws_subnet.main-public-1.id}"
  route_table_id = "${aws_route_table.main-public.id}"
}
resource "aws_route_table_association" "main-public-2-a" {
  subnet_id = "${aws_subnet.main-public-2.id}"
  route_table_id = "${aws_route_table.main-public.id}"
}
resource "aws_route_table_association" "main-public-3-a" {
  subnet_id = "${aws_subnet.main-public-3.id}"
  route_table_id = "${aws_route_table.main-public.id}"
}
