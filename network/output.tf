output "pub_subnet_1_id" {
  value = aws_subnet.main-pub-1.id
}

output "pub_subnet_2_id" {
  value = aws_subnet.main-pub-2.id
}

output "pri_subnet_1_id" {
  value = aws_subnet.main-pri-1.id
}

output "pri_subnet_2_id" {
  value = aws_subnet.main-pri-2.id
}

output "sg_admin_traffic" {
  value = aws_security_group.allow-traffic.id
}

output "sg_wp_app_internal_traffic" {
  value = aws_security_group.wp_app.id
}

output "sg_wp_rds_internal" {
  value = aws_security_group.allow-mariadb.id
}