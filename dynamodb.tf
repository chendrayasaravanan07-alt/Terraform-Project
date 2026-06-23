resource "aws_dynamodb_table" "file_metadata" {

  name         = "FileMetadata-TF"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "fileid"

  attribute {
    name = "fileid"
    type = "S"
  }

  tags = {
    Project = "ServerlessFileMetadataExtractor"
  }
}