resource "aws_ecs_task_definition" "apiTaskDefinition" {
  family                   = "${var.clusterName}-apiTask"
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
        image : "208383029138.dkr.ecr.us-east-1.amazonaws.com/backendapp:latest",
        memory : 512,
        name : "apiService",
        networkMode : "awsvpc",
        essential : true,
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
            awslogs-stream-prefix : var.clusterName
          }
        }
      }
    ]
  )
}