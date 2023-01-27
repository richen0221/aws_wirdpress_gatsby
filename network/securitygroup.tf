resource "aws_security_group" "allow-traffic" {
  vpc_id      = aws_vpc.main.id
  name        = "${var.PRJ_NAME}-allow-traffic"
  description = "allow all egress and admin ingress ip"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    prefix_list_ids = [aws_ec2_managed_prefix_list.admin_prefix.id]
    description     = "admin remote"
  }


  tags = {
    Name = "${var.PRJ_NAME}-allow-admin-traffic"
  }
}

resource "aws_security_group" "wp_app" {
  vpc_id      = aws_vpc.main.id
  name        = "${var.PRJ_NAME}-wp_app"
  description = "allow internal ip"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.200.0.0/16"]
    description = "internal"
  }

  tags = {
    Name = "${var.PRJ_NAME}-wp_app"
  }
}

resource "aws_security_group" "allow-mariadb" {
  vpc_id      = aws_vpc.main.id
  name        = "${var.PRJ_NAME}-allow-mariadb"
  description = "allow-mariadb"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.200.1.0/24", "10.200.2.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    self        = true
  }
  tags = {
    Name = "${var.PRJ_NAME}-allow-internal-mariadb"
  }
}
