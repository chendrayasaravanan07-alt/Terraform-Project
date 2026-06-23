resource "aws_lambda_function" "upload_lambda" {

  function_name = "UploadFileLambda-TF"

  role = aws_iam_role.lambda_role.arn

  runtime = "python3.12"

  handler = "UploadFileLambda.lambda_handler"

  filename         = data.archive_file.upload_zip.output_path
  source_code_hash = data.archive_file.upload_zip.output_base64sha256

  environment {
    variables = {
      BUCKET_NAME = aws_s3_bucket.file_storage.bucket
    }
  }
}


resource "aws_lambda_function" "metadata_lambda" {

  function_name = "MetadataProcessor-TF"

  role = aws_iam_role.lambda_role.arn

  runtime = "python3.12"

  handler = "MetadataProcessor.lambda_handler"

  filename         = data.archive_file.metadata_zip.output_path
  source_code_hash = data.archive_file.metadata_zip.output_base64sha256

  environment {
    variables = {
      TABLE_NAME  = aws_dynamodb_table.file_metadata.name
      BUCKET_NAME = aws_s3_bucket.file_storage.bucket
    }
  }
}


resource "aws_lambda_function" "list_lambda" {

  function_name = "ListFiles-TF"

  role = aws_iam_role.lambda_role.arn

  runtime = "python3.12"

  handler = "ListFiles.lambda_handler"

  filename         = data.archive_file.list_zip.output_path
  source_code_hash = data.archive_file.list_zip.output_base64sha256

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.file_metadata.name
    }
  }
}


resource "aws_lambda_function" "download_lambda" {

  function_name = "DownloadFileLambda-TF"

  role = aws_iam_role.lambda_role.arn

  runtime = "python3.12"

  handler = "DownloadFileLambda.lambda_handler"

  filename         = data.archive_file.download_zip.output_path
  source_code_hash = data.archive_file.download_zip.output_base64sha256

  environment {
    variables = {
      BUCKET_NAME = aws_s3_bucket.file_storage.bucket
    }
  }
}


resource "aws_lambda_function" "delete_lambda" {

  function_name = "DeleteFileLambda-TF"

  role = aws_iam_role.lambda_role.arn

  runtime = "python3.12"

  handler = "DeleteFileLambda.lambda_handler"

  filename         = data.archive_file.delete_zip.output_path
  source_code_hash = data.archive_file.delete_zip.output_base64sha256

  environment {
    variables = {
      TABLE_NAME  = aws_dynamodb_table.file_metadata.name
      BUCKET_NAME = aws_s3_bucket.file_storage.bucket
    }
  }
}


resource "aws_lambda_permission" "allow_s3" {

  statement_id = "AllowExecutionFromS3"

  action = "lambda:InvokeFunction"

  function_name = aws_lambda_function.metadata_lambda.function_name

  principal = "s3.amazonaws.com"

  source_arn = aws_s3_bucket.file_storage.arn
}


resource "aws_s3_bucket_notification" "bucket_notification" {

  bucket = aws_s3_bucket.file_storage.id

  lambda_function {

    lambda_function_arn = aws_lambda_function.metadata_lambda.arn

    events = ["s3:ObjectCreated:*"]
  }

  depends_on = [
    aws_lambda_permission.allow_s3
  ]
}