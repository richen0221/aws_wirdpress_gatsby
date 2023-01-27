# get the latest ubuntu ami id
data "aws_ami" "amazonlinux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  owners = ["137112412989"] # Amazon Linux
}

resource "aws_key_pair" "wp_keypair" {
  key_name   = "wordpress-key"
  public_key = file(var.WP_PUBKEY)
}


resource "aws_instance" "wp_app" {
  count = 1
  ami   = data.aws_ami.amazonlinux.id

  root_block_device {
    volume_size           = 8
    volume_type           = "gp2"
    delete_on_termination = true
  }
  instance_type          = "t3a.micro"
  subnet_id              = var.wp_app_subnet_id
  vpc_security_group_ids = var.wp_app_sg_id


  private_ip = "10.200.1.10"
  key_name   = aws_key_pair.wp_keypair.key_name # use key pair from local
  user_data = file("server/scripts/provision.sh")


  tags = {
    Name = "${var.PRJ_NAME}-wp"
  }
  # depends_on = ["aws_db_instance.mariadb"]
}

resource "aws_instance" "gatsby_app" {
  count = 1
  ami   = data.aws_ami.amazonlinux.id

  root_block_device {
    volume_size           = 8
    volume_type           = "gp2"
    delete_on_termination = true
  }
  instance_type          = "t3a.medium"
  subnet_id              = var.wp_app_subnet_id
  vpc_security_group_ids = var.wp_app_sg_id


  private_ip = "10.200.1.11"
  key_name   = aws_key_pair.wp_keypair.key_name # use key pair from local
  user_data = file("server/scripts/provision.sh")


  tags = {
    Name = "${var.PRJ_NAME}-gatsby"
  }
  # depends_on = ["aws_db_instance.mariadb"]
}