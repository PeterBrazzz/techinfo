output "profile_name" {
  description = "Output for vpc_ec2 module"
  value       = aws_iam_instance_profile.this.name
}
