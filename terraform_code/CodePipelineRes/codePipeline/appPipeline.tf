resource "aws_codepipeline" "example" {
  name = "${var.repositoryName}-pipeline"

  role_arn = var.codePipelineIamArn

  artifact_store {
    location = var.s3BucketId
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name     = "SourceAction"
      category = "Source"
      owner    = "AWS"
      provider = "CodeCommit"
      version  = "1"
      configuration = {
        RepositoryName = var.repositoryName
        BranchName     = var.branch
        OutputArtifactFormat = "CODEBUILD_CLONE_REF"
      }

      output_artifacts = ["source_artifact"]
    }
  }

  dynamic stage {
    for_each = var.DockerBuildProjectName
    content {
      name = split("-",stage.value)[0]
      action {
        name            = split("-",stage.value)[0]
        category        = "Build"
        owner           = "AWS"
        provider        = "CodeBuild"
        version         = "1"
        input_artifacts = ["source_artifact"]
        configuration = {
          ProjectName = stage.value,
          EnvironmentVariables = jsonencode([
            {
              name  = "AWS_DEFAULT_REGION"
              type  = "PLAINTEXT"
              value = "${var.region}"
            },
            {
              name  = "AWS_ACCOUNT_ID"
              type  = "PLAINTEXT"
              value = "${var.accountID}"
            },
            {
              name  = "REPOSITORYNAME"
              type  = "PLAINTEXT"
              value = "${var.repositoryName}"
            }
            ])
        }
      }
    }
  }
}