resource "aws_rds_cluster" "rds-cluster" {
  cluster_identifier                = var.cluster_name
  engine                            = "aurora-mysql"
  availability_zones                = ["ap-northeast-2a", "ap-northeast-2c"]
  master_username                   = var.username
  master_password                   = var.password
  deletion_protection               = false
  apply_immediately                 = true
  backup_retention_period           = 30
  preferred_backup_window           = "09:10-09:40"  # UTC (KST-9)
  preferred_maintenance_window      = "wed:09:45-wed:10:45"
  port                              = 3306
  vpc_security_group_ids            = var.my_vpc_sg_ids
  db_cluster_parameter_group_name   = var.my_cluster_parameter_group_name
  db_subnet_group_name              = var.my_subnet_group_name
  storage_encrypted                 = true
  skip_final_snapshot               = true

  lifecycle {
    ignore_changes = [master_password, availability_zones]
  }
}

resource "aws_rds_cluster_instance" "rds-instance" {
  count                             = 2
  identifier                        = "${var.cluster_name}-${count.index}"
  engine                            = "aurora-mysql"
  engine_version                    = "5.7.12"
  cluster_identifier                = aws_rds_cluster.rds-cluster.id
  instance_class                    = var.instance_class
  db_subnet_group_name              = var.my_subnet_group_name
  db_parameter_group_name           = var.my_db_parameter_group_name
  publicly_accessible               = true
}
