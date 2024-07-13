resource "aws_iam_role" "cluster_iam" {
  name = "${var.clusterName}-cluster_iam"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode(
    {
      Version = "2012-10-17",
      Statement = [
        {
          Effect : "Allow",
          Principal : {
            Service : "ecs-tasks.amazonaws.com"
          },
          Action : [
            "sts:AssumeRole"
          ]
        }
      ]
    }
  )
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]

  tags = {
    Environment = var.clusterName
  }
}

resource "aws_iam_role_policy" "clusterEcrAccess" {
  name   = "ecrPolicy-${var.repositoryName}"
  role   = aws_iam_role.cluster_iam.id
  policy = jsonencode(
    {
      Version = "2012-10-17",
      Statement = [
        {
          Effect = "Allow",
          Resource = [
            "arn:aws:ecr:${var.region}:${var.accountID}:repository/${var.repositoryName}"
          ],
          Action = [
            "ecr:BatchGetImage",
            "ecr:GetDownloadUrlForLayer",
            "ecr:GetAuthorizationToken"
          ]
        }
      ]
    }
  )
}
