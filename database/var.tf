variable "PRJ_NAME" {
  type = string
}

variable "db_subnet" {
  type = list(any)
}

variable "db_sg_id" {
  type = list(any)
}

variable "RDS_USER" {
  type = string
}

variable "RDS_PASSWORD" {
  type = string
}