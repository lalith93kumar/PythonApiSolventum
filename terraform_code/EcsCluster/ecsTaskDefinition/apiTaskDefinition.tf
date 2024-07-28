resource "aws_ecs_task_definition" "apiTaskDefinition" {
  family                   = join("-", [var.clusterName,"apiTask",replace(var.repositoryVersion,".","-")])
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.iam_arm
      tags = {
        Environment = var.clusterName
    }
  container_definitions = jsonencode(
    [
      {
        cpu : 256,
        image : "${var.accountID}.dkr.ecr.${var.region}.amazonaws.com/${lower(var.repositoryName)}:${var.repositoryVersion}",
        memory : 512,
        name : "apiService",
        networkMode : "awsvpc",
        essential : true,
        environment = [
          {
            name  = "DBINSTANCE_ENDPOINT"
            value = var.rds_endpoint
          },
        ]
        portMappings : [
          {
            containerPort : 5000,
            hostPort : 5000,
            protocol : "http"
          }
        ],
        logConfiguration : {
          logDriver : "awslogs",
          options : {
            awslogs-group : "/log/${var.clusterName}",
            awslogs-region : var.region,
            awslogs-stream-prefix : "apiTask-${var.repositoryVersion}"
          }
        }
      }
    ]
  )
}