output "s3BucketId" {
  value = aws_s3_bucket.codeArtifactoryBucket.id
  description = "Repository Url from codeCommit"
}

output "s3BucketArn" {
  value = aws_s3_bucket.codeArtifactoryBucket.arn
  description = "Repository Url from codeCommit"
}

output "s3BucketTerraformBackupArn" {
  value = data.aws_s3_bucket.terraformBackupFlaskAPIBucket.arn
  description = "Repository Url from codeCommit"
}