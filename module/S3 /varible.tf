variable "s3_name" {
  type        = string
  default     = null
  description = "name of s3 bucket"
}
variable "force_destroy" {
  type        = bool
  default     = false
  description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
}
variable "object_lock_enabled" {
  type        = bool
  default     = false
  description = "Whether S3 bucket should have an Object Lock configuration enabled."
}
variable "tags_name" {
  type        = string
  default     = null
  description = "tag of s3 bucket"
}
variable "aws_iam_policy_document" {
  type        = string
  default     = ""
  sensitive   = true
  description = "The text of the policy. Although this is a bucket policy rather than an IAM policy, the aws_iam_policy_document data source may be used, so long as it specifies a principal. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide. Note: Bucket policies are limited to 20 KB in size."
}
variable "versioning_status" {
  type        = string
  default     = "Enabled"
  description = "Required if versioning_configuration mfa_delete is enabled) Concatenation of the authentication device's serial number, a space, and the value that is displayed on your authentication device."
}
