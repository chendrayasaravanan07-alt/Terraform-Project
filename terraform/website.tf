resource "aws_s3_bucket_website_configuration" "web_config" {

  bucket = aws_s3_bucket.web_hosting.id

  index_document {
    suffix = "index.html"
  }

  error_document {
  key = "index.html"
}
}

resource "aws_s3_bucket_public_access_block" "web_public" {

  bucket = aws_s3_bucket.web_hosting.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "web_policy" {

  bucket = aws_s3_bucket.web_hosting.id

  depends_on = [
    aws_s3_bucket_public_access_block.web_public
  ]

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid       = "PublicRead"
        Effect    = "Allow"
        Principal = "*"

        Action = [
          "s3:GetObject"
        ]

        Resource = [
          "${aws_s3_bucket.web_hosting.arn}/*"
        ]
      }
    ]
  })
}