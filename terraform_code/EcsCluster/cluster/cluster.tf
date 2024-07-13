resource "aws_ecs_cluster" "TestCluster" {
  name = "${var.clusterName}-testCluster"
    tags = {
        Environment = var.clusterName
    }
}