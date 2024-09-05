# Module: ci_cd

`ci_cd` is a terraform module that creates a Code Pipeline that deploys code to the CloudFront distribution and invalidates cache using Lambda function.

# Module structure

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.46 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.46 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.code_build](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_codebuild_project.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |
| [aws_codepipeline.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codepipeline) | resource |
| [aws_codestarnotifications_notification_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codestarnotifications_notification_rule) | resource |
| [aws_iam_role.code_build](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.code_pipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.event_bridge_scheduler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.code_build_artifact](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.code_build_cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.code_build_external](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.code_build_lambda_updating](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.code_build_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.code_build_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.code_pipeline_artifact](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.code_pipeline_build](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.code_pipeline_source](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.event_bridge_scheduler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_scheduler_schedule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/scheduler_schedule) | resource |
| [aws_security_group.code_build](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.artifact](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.code_build_cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.code_build_lambda_updating](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.code_build_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.code_build_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.code_pipeline_build](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.code_pipeline_scheduler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.code_pipeline_source](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_artifact_bucket_arn"></a> [artifact\_bucket\_arn](#input\_artifact\_bucket\_arn) | Artifact bucket ARN. | `string` | n/a | yes |
| <a name="input_artifact_bucket_id"></a> [artifact\_bucket\_id](#input\_artifact\_bucket\_id) | Artifact bucket ID. | `string` | n/a | yes |
| <a name="input_av_lambda"></a> [av\_lambda](#input\_av\_lambda) | AV lambda ARN. | `string` | n/a | yes |
| <a name="input_chatbot_arn"></a> [chatbot\_arn](#input\_chatbot\_arn) | ChatBot ARN for notifications. | `string` | n/a | yes |
| <a name="input_code_build_artifact_name"></a> [code\_build\_artifact\_name](#input\_code\_build\_artifact\_name) | Artifact name of CodeBuild project. | `string` | `"application"` | no |
| <a name="input_code_build_build_timeout"></a> [code\_build\_build\_timeout](#input\_code\_build\_build\_timeout) | How long in minutes, from 5 to 480 (8 hours), for AWS CodeBuild to wait until timing out any related build that does not get marked as completed? | `number` | `60` | no |
| <a name="input_code_build_cloudwatch_kms_key_id"></a> [code\_build\_cloudwatch\_kms\_key\_id](#input\_code\_build\_cloudwatch\_kms\_key\_id) | CodeBuild CloudWatch log group kms key id. | `string` | `null` | no |
| <a name="input_code_build_cloudwatch_tags"></a> [code\_build\_cloudwatch\_tags](#input\_code\_build\_cloudwatch\_tags) | A key - value list of tags, that is attached to CloudWatch log group of CodeBuild project. | `map(string)` | `{}` | no |
| <a name="input_code_build_compute_type"></a> [code\_build\_compute\_type](#input\_code\_build\_compute\_type) | Compute type CodeBuild environment uses. Ignored if environment\_type is 'LINUX\_CONTAINER' or 'LINUX\_GPU\_CONTAINER'. | `string` | `"BUILD_GENERAL1_SMALL"` | no |
| <a name="input_code_build_description"></a> [code\_build\_description](#input\_code\_build\_description) | Description of CodeBuild project. | `string` | `null` | no |
| <a name="input_code_build_environment_vars"></a> [code\_build\_environment\_vars](#input\_code\_build\_environment\_vars) | A list of plaintext env variables is set to CodeBuild project. | <pre>list(<br>    object({<br>      name  = string<br>      value = string<br>    })<br>  )</pre> | `[]` | no |
| <a name="input_code_build_environment_vars_secrets_manager"></a> [code\_build\_environment\_vars\_secrets\_manager](#input\_code\_build\_environment\_vars\_secrets\_manager) | A list of env variables from secrets manager is set to CodeBuild project. | <pre>list(<br>    object({<br>      keys = list(string)<br>      arn  = string<br>      kms  = string<br>    })<br>  )</pre> | `[]` | no |
| <a name="input_code_build_environment_vars_ssm"></a> [code\_build\_environment\_vars\_ssm](#input\_code\_build\_environment\_vars\_ssm) | A list of env variables from ssm parameters is set to CodeBuild project. | <pre>list(<br>    object({<br>      name = string<br>      arn  = string<br>      kms  = string<br>    })<br>  )</pre> | `[]` | no |
| <a name="input_code_build_external_iam_policies"></a> [code\_build\_external\_iam\_policies](#input\_code\_build\_external\_iam\_policies) | A list of external iam policies attached to CodeBuild project. | `list(string)` | `[]` | no |
| <a name="input_code_build_iam_role_tags"></a> [code\_build\_iam\_role\_tags](#input\_code\_build\_iam\_role\_tags) | A key - value list of tags, that is attached to IAM role of CodeBuild project. | `map(string)` | `{}` | no |
| <a name="input_code_build_image"></a> [code\_build\_image](#input\_code\_build\_image) | CodeBuild environment image. | `string` | `"aws/codebuild/amazonlinux2-x86_64-standard:4.0"` | no |
| <a name="input_code_build_image_privileged_mode"></a> [code\_build\_image\_privileged\_mode](#input\_code\_build\_image\_privileged\_mode) | Should CodeBuild image run in privilleged mode? | `bool` | `true` | no |
| <a name="input_code_build_image_pull_credentials_type"></a> [code\_build\_image\_pull\_credentials\_type](#input\_code\_build\_image\_pull\_credentials\_type) | The type of credentials AWS CodeBuild uses to pull images in your build. | `string` | `"CODEBUILD"` | no |
| <a name="input_code_build_queued_timeout"></a> [code\_build\_queued\_timeout](#input\_code\_build\_queued\_timeout) | How long in minutes, from 5 to 480 (8 hours), a build is allowed to be queued before it times out? | `number` | `480` | no |
| <a name="input_code_build_sg_tags"></a> [code\_build\_sg\_tags](#input\_code\_build\_sg\_tags) | A key - value list of tags, that is attached to SG of CodeBuild project. | `map(string)` | `{}` | no |
| <a name="input_code_build_source_buildspec"></a> [code\_build\_source\_buildspec](#input\_code\_build\_source\_buildspec) | A path to the buildspec in the repo. | `string` | `"./automation/docker-buildspec.yaml"` | no |
| <a name="input_code_build_subnet_ids"></a> [code\_build\_subnet\_ids](#input\_code\_build\_subnet\_ids) | List of subnet IDs where Code Build will be hosted. | `list(string)` | n/a | yes |
| <a name="input_code_build_tags"></a> [code\_build\_tags](#input\_code\_build\_tags) | A key - value list of tags, that is attached to the CodeBuild project. | `map(string)` | `{}` | no |
| <a name="input_code_build_vpc_id"></a> [code\_build\_vpc\_id](#input\_code\_build\_vpc\_id) | VPC ID where CodeBuild resources are created. | `string` | n/a | yes |
| <a name="input_code_pipeline_iam_role_tags"></a> [code\_pipeline\_iam\_role\_tags](#input\_code\_pipeline\_iam\_role\_tags) | A key - value list of tags, that is attached to IAM role of CodePipeline project. | `map(string)` | `{}` | no |
| <a name="input_code_pipeline_scheduler_iam_role_tags"></a> [code\_pipeline\_scheduler\_iam\_role\_tags](#input\_code\_pipeline\_scheduler\_iam\_role\_tags) | A key - value list of tags, that is attached to IAM role of EventBrige Scheduler project. | `map(string)` | `{}` | no |
| <a name="input_code_pipeline_scheduler_tags"></a> [code\_pipeline\_scheduler\_tags](#input\_code\_pipeline\_scheduler\_tags) | A key - value list of tags, that is attached to the EventBrige Scheduler project. | `map(string)` | `{}` | no |
| <a name="input_code_pipeline_source"></a> [code\_pipeline\_source](#input\_code\_pipeline\_source) | CodePipeline source configuration. | <pre>object({<br>    codestar_connection_arn = string<br>    repository_id           = string<br>    repository_branch       = string<br>  })</pre> | n/a | yes |
| <a name="input_code_pipeline_tags"></a> [code\_pipeline\_tags](#input\_code\_pipeline\_tags) | A key - value list of tags, that is attached to the CodePipeline project. | `map(string)` | `{}` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Name prefix for all resources. | `string` | n/a | yes |
| <a name="input_s3_sse_algorithm"></a> [s3\_sse\_algorithm](#input\_s3\_sse\_algorithm) | The server-side encryption algorithm of s3 bucket. If empty, no encryption is set. | `string` | `"AES256"` | no |
| <a name="input_s3_sse_kms_key_id"></a> [s3\_sse\_kms\_key\_id](#input\_s3\_sse\_kms\_key\_id) | The AWS KMS master key ID used for the SSE-KMS encryption. | `string` | `null` | no |
| <a name="input_s3_tags"></a> [s3\_tags](#input\_s3\_tags) | A key - value list of tags, that is attached to S3 bucket. | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
