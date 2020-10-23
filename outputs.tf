output "this_s3_bucket_id" {
  description = "The name of the bucket."
  value       = element(concat(aws_s3_bucket.this.*.id, list("")), 0)
}

output "this_s3_bucket_arn" {
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname."
  value       = element(concat(aws_s3_bucket.this.*.arn, list("")), 0)
}

output "this_s3_bucket_region" {
  description = "The AWS region this bucket resides in."
  value       = element(concat(aws_s3_bucket.this.*.region, list("")), 0)
}
