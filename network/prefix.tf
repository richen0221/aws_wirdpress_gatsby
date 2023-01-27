resource "aws_ec2_managed_prefix_list" "admin_prefix" {
  name           = "wp-admin-ips"
  address_family = "IPv4"
  max_entries    = 10

  tags = {
    Env = "${var.PRJ_NAME}-admin_prefix"
  }
}