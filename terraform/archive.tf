data "archive_file" "upload_zip" {
  type        = "zip"
  source_file = "${path.module}/../lambda/UploadFileLambda.py"
  output_path = "${path.module}/upload.zip"
}

data "archive_file" "metadata_zip" {
  type        = "zip"
  source_file = "${path.module}/../lambda/MetadataProcessor.py"
  output_path = "${path.module}/metadata.zip"
}

data "archive_file" "list_zip" {
  type        = "zip"
  source_file = "${path.module}/../lambda/ListFiles.py"
  output_path = "${path.module}/list.zip"
}

data "archive_file" "download_zip" {
  type        = "zip"
  source_file = "${path.module}/../lambda/DownloadFileLambda.py"
  output_path = "${path.module}/download.zip"
}

data "archive_file" "delete_zip" {
  type        = "zip"
  source_file = "${path.module}/../lambda/DeleteFileLambda.py"
  output_path = "${path.module}/delete.zip"
}