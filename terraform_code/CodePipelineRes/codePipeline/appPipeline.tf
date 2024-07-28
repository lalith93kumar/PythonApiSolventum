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
      name     = "Source"
      category = "Source"
      owner    = "AWS"
      provider = "CodeStarSourceConnection"
      version  = "1"
      configuration = {
        ConnectionArn = aws_codestarconnections_connection.gitHubConnection.arn
        FullRepositoryId = var.repositoryUrl
        BranchName     = var.branch
        OutputArtifactFormat = "CODEBUILD_CLONE_REF"
      }

      output_artifacts = ["source_artifact"]
    }
  }

  dynamic stage {
    for_each = var.DockerBuildProjectName
    content {
      name = split("-",stage.value["name"])[0]
      dynamic action {
        for_each = strcontains(lower(split("-",stage.value["name"])[0]),"approval") ? [1] : []
        content {
          name     = "Approval"
          category = "Approval"
          owner    = "AWS"
          provider = "Manual"
          version  = "1"
        }
      }
      dynamic action {
        for_each = strcontains(lower(split("-",stage.value["name"])[0]),"approval") ? [] : [1]
        content {
          name            = split("-",stage.value["name"])[0]
          category        = "Build"
          owner           = "AWS"
          provider        = "CodeBuild"
          version         = "1"
          input_artifacts = [stage.value["inputArtifacts"]]
          output_artifacts = [stage.value["outputArtifact"]]
          configuration = {
            ProjectName = join("-",[stage.value["name"],var.repositoryName]),
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
                },
                {
                  name  = "CLUSTERNAME"
                  type  = "PLAINTEXT"
                  value = "${var.clusterName}"
                }
              ])
          }
        }
      }
    }
  }
}

resource "aws_codestarconnections_connection" "gitHubConnection" {
  name          = "gitHubConnection"
  provider_type = "GitHub"
}

# locals {
#   webhook_secret = "super-secret"
# }

# resource "aws_codepipeline_webhook" "bar" {
#   name            = "test-webhook-github-bar" 
#   authentication  = "GITHUB_HMAC" 
#   target_action   = "Source"
#   target_pipeline = "${aws_codepipeline.example.name}"

#   authentication_configuration {
#     secret_token = "${local.webhook_secret}"
#   }

#   filter {
#     json_path    = "$.ref"
#     match_equals = "refs/heads/{Branch}"
#   }
# }

# resource "github_repository_webhook" "test" {
#   repository = "lalith93kumar/PythonApiSolventum"

#   configuration {
#     url          = "${aws_codepipeline_webhook.bar.url}"
#     content_type = "form"
#     insecure_ssl = true
#     secret       = "${local.webhook_secret}"
#   }

#   events = ["push"]
# }