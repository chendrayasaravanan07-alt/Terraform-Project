resource "aws_apigatewayv2_api" "file_api" {

  name = "serverless-file-api"

  protocol_type = "HTTP"
}
resource "aws_apigatewayv2_integration" "upload_integration" {

  api_id = aws_apigatewayv2_api.file_api.id

  integration_type = "AWS_PROXY"

  integration_uri = aws_lambda_function.upload_lambda.invoke_arn

  integration_method = "POST"

  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "upload_route" {

  api_id = aws_apigatewayv2_api.file_api.id

  route_key = "GET /upload-url"

  target = "integrations/${aws_apigatewayv2_integration.upload_integration.id}"
}

resource "aws_apigatewayv2_integration" "list_integration" {

  api_id = aws_apigatewayv2_api.file_api.id

  integration_type = "AWS_PROXY"

  integration_uri = aws_lambda_function.list_lambda.invoke_arn

  integration_method = "POST"

  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "list_route" {

  api_id = aws_apigatewayv2_api.file_api.id

  route_key = "GET /files"

  target = "integrations/${aws_apigatewayv2_integration.list_integration.id}"
}

resource "aws_apigatewayv2_integration" "download_integration" {

  api_id = aws_apigatewayv2_api.file_api.id

  integration_type = "AWS_PROXY"

  integration_uri = aws_lambda_function.download_lambda.invoke_arn

  integration_method = "POST"

  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "download_route" {

  api_id = aws_apigatewayv2_api.file_api.id

  route_key = "GET /download"

  target = "integrations/${aws_apigatewayv2_integration.download_integration.id}"
}

resource "aws_apigatewayv2_integration" "delete_integration" {

  api_id = aws_apigatewayv2_api.file_api.id

  integration_type = "AWS_PROXY"

  integration_uri = aws_lambda_function.delete_lambda.invoke_arn

  integration_method = "POST"

  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "delete_route" {

  api_id = aws_apigatewayv2_api.file_api.id

  route_key = "GET /delete"

  target = "integrations/${aws_apigatewayv2_integration.delete_integration.id}"
}

resource "aws_apigatewayv2_stage" "default" {

  api_id = aws_apigatewayv2_api.file_api.id

  name = "$default"

  auto_deploy = true
}

resource "aws_lambda_permission" "api_upload" {

  statement_id = "AllowAPIGatewayUpload"

  action = "lambda:InvokeFunction"

  function_name = aws_lambda_function.upload_lambda.function_name

  principal = "apigateway.amazonaws.com"
}

resource "aws_lambda_permission" "api_list" {

  statement_id = "AllowAPIGatewayList"

  action = "lambda:InvokeFunction"

  function_name = aws_lambda_function.list_lambda.function_name

  principal = "apigateway.amazonaws.com"
}

resource "aws_lambda_permission" "api_download" {

  statement_id = "AllowAPIGatewayDownload"

  action = "lambda:InvokeFunction"

  function_name = aws_lambda_function.download_lambda.function_name

  principal = "apigateway.amazonaws.com"
}

resource "aws_lambda_permission" "api_delete" {

  statement_id = "AllowAPIGatewayDelete"

  action = "lambda:InvokeFunction"

  function_name = aws_lambda_function.delete_lambda.function_name

  principal = "apigateway.amazonaws.com"
}