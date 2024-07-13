output "cluster_id" {
  value = aws_ecs_cluster.TestCluster.id
  description = "cluster ID"
}

output "clusterName" {
  value = aws_ecs_cluster.TestCluster.name
  description = "cluster ID"
}