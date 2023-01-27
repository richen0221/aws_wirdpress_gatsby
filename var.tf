variable "PRJ_NAME" {
  default = "mywordpress2"
}

variable "ADMIN_SG_IP" {
  default = ["1.2.3.4/32"]
}

variable "WP_PUBKEY" {
  default = "~/.ssh/id_rsa.pub"
}

variable "WP_PRIKEY" {
  default = "~/.ssh/id_rsa"
}

variable "RDS_USER" {
  default = "wpuser"
}

variable "RDS_PASSWORD" {
  default = "1qaz2wsx"
}
