resource "aws_codepipeline" "this" {
  name     = local.code_pipeline_project
  role_arn = aws_iam_role.code_pipeline.arn

  artifact_store {
    location = var.artifact_bucket_id
    type     = "S3"
    dynamic "encryption_key" {
      for_each = local.s3.encrypted ? [true] : []
      content {
        type = "KMS"
        id   = var.s3_sse_kms_key_id
      }
    }
  }

  stage {
    name = "Source"
    action {
      name      = "GitHub"
      namespace = "SourceVariables"
      category  = "Source"
      owner     = "AWS"
      provider  = "CodeStarSourceConnection"
      version   = "1"
      configuration = {
        ConnectionArn        = var.code_pipeline_source.codestar_connection_arn
        FullRepositoryId     = var.code_pipeline_source.repository_id
        BranchName           = var.code_pipeline_source.repository_branch
        OutputArtifactFormat = "CODE_ZIP"
      }
      output_artifacts = [local.code_pipeline.source_artifact]
      run_order        = 1
    }
  }

  stage {
    name = "Build"
    action {
      name     = "Build"
      category = "Build"
      owner    = "AWS"
      provider = "CodeBuild"
      version  = "1"
      configuration = {
        ProjectName = aws_codebuild_project.this.name
      }
      input_artifacts = [local.code_pipeline.source_artifact]
      output_artifacts = [local.code_pipeline.build_artifact]
      run_order       = 1
    }
  }

  stage {
    name = "Deploy"
    action {
      name     = "Deploy"
      category = "Deploy"
      owner    = "AWS"
      provider = "ECS"
      version  = "1"
      configuration = {
        ClusterName = var.ecs_cluster_name
        ServiceName = var.ecs_service_name
        FileName    = "imagedefinitions.json"
      }
      input_artifacts = [local.code_pipeline.build_artifact]
      run_order       = 1
    }
  }

  tags       = local.code_pipeline.tags
  depends_on = [aws_iam_role.code_pipeline]
}
