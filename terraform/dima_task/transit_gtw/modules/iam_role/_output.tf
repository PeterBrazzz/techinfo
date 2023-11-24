output "profile_name" {
  description = "Profile name for instances."
  value       = aws_iam_instance_profile.this.name
}
