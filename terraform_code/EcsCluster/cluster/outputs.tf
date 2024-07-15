output "clusterId" {
  value = aws_ecs_cluster.TestCluster.id
  description = "ECS cluster ID"
}

output "clusterName" {
  value = aws_ecs_cluster.TestCluster.name
  description = "ECS cluster Name"
}