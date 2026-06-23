resource "aws_s3_bucket" "file_storage" {
  bucket = "file-store172-tf"
}

resource "aws_s3_bucket" "web_hosting" {
  bucket = "web-host172-tf"
}