provider "aws" {
  region  = "ap-northeast-1"
  profile = "default"
}

module "network" {
  source   = "./network"
  PRJ_NAME = var.PRJ_NAME
}

module "database" {
  source       = "./database"
  PRJ_NAME     = var.PRJ_NAME
  db_subnet    = [module.network.pri_subnet_1_id, module.network.pri_subnet_2_id]
  db_sg_id     = [module.network.sg_wp_rds_internal]
  RDS_USER     = var.RDS_USER
  RDS_PASSWORD = var.RDS_PASSWORD
}

module "server" {
  source           = "./server"
  wp_app_subnet_id = module.network.pub_subnet_1_id
  wp_app_sg_id     = [module.network.sg_admin_traffic, module.network.sg_wp_app_internal_traffic]
  PRJ_NAME         = var.PRJ_NAME
  WP_PUBKEY        = var.WP_PUBKEY
  WP_PRIKEY        = var.WP_PRIKEY
}