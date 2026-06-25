resource "aws_s3_object" "index" {

  bucket = aws_s3_bucket.web_hosting.bucket

  key = "index.html"

  source = "${path.module}/../frontend/index.html"

  content_type = "text/html"
}

resource "aws_s3_object" "css" {

  bucket = aws_s3_bucket.web_hosting.bucket

  key = "style.css"

  source = "${path.module}/../frontend/style.css"

  content_type = "text/css"
}

resource "aws_s3_object" "js" {

  bucket = aws_s3_bucket.web_hosting.bucket

  key = "script.js"

  source = "${path.module}/../frontend/script.js"

  content_type = "application/javascript"
}