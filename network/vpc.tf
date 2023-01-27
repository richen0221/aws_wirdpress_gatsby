# for VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.200.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "${var.PRJ_NAME}"
  }
}

# Setup public subnet
resource "aws_subnet" "main-pub-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.200.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-northeast-1a"

  tags = {
    Name = "${aws_vpc.main.tags.Name}-pub-1"
  }
}

resource "aws_subnet" "main-pub-2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.200.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-northeast-1c"

  tags = {
    Name = "${aws_vpc.main.tags.Name}-pub-2"
  }
}
# Setup provate subnet
resource "aws_subnet" "main-pri-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.200.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-northeast-1a"

  tags = {
    Name = "${aws_vpc.main.tags.Name}-pri-1"
  }
}

resource "aws_subnet" "main-pri-2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.200.4.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-northeast-1c"

  tags = {
    Name = "${aws_vpc.main.tags.Name}-pri-2"
  }
}

# setup internet gateway
resource "aws_internet_gateway" "main-gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${aws_vpc.main.tags.Name}-gw"
  }
}
# create route table
resource "aws_route_table" "main-pub" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-gw.id
  }

  tags = {
    Name = "${aws_vpc.main.tags.Name}-pub-1"
  }
}

# associate the subnets to route table
resource "aws_route_table_association" "main-pub-1-a" {
  subnet_id      = aws_subnet.main-pub-1.id
  route_table_id = aws_route_table.main-pub.id
}

resource "aws_route_table_association" "main-pub-1-c" {
  subnet_id      = aws_subnet.main-pub-2.id
  route_table_id = aws_route_table.main-pub.id
}
