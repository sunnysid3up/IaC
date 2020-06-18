resource "aws_elasticache_replication_group" "<CHANGE>" {
  replication_group_id              = "<CHANGE>"
  replication_group_description     = "<CHANGE>"
  engine                            = "redis"
  engine_version                    = "5.0.6"
  parameter_group_name              = "default.redis5.0"
  node_type                         = "cache.t3.medium"
  number_cache_clusters             = 3
  automatic_failover_enabled        = true
  subnet_group_name                 = var.subnet_group_name
  security_group_ids                = var.security_group_ids
}

# resource "aws_elasticache_cluster" "messaging-replica" {
#   cluster_id           = "messaging-replica"
#   replication_group_id = aws_elasticache_replication_group.messaging.id
# }