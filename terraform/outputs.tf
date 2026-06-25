output "api_gateway_url" {

  value = aws_apigatewayv2_stage.default.invoke_url
}

output "file_storage_bucket" {

  value = aws_s3_bucket.file_storage.bucket
}

output "dynamodb_table" {

  value = aws_dynamodb_table.file_metadata.name
}

output "cloudfront_domain" {
  value = aws_cloudfront_distribution.frontend.domain_name
}

output "test" {
  value = "state-working#"
}