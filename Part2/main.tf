# Declare the region variable
variable "region" {
  description = "AWS Region"
  default     = "ap-south-1"  # Replace with your desired region if necessary
}

# IAM Role for Lambda function with policy
resource "aws_iam_role" "lambda_role" {
  name               = "lambda-s3-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

# Define the assume role policy for Lambda execution
data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions   = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

# Create the Lambda policy for S3 access
resource "aws_iam_policy" "lambda_policy" {
  name   = "lambda-s3-policy"
  policy = data.aws_iam_policy_document.lambda_policy.json
}

# Define the permissions to access the S3 bucket
data "aws_iam_policy_document" "lambda_policy" {
  statement {
    actions   = ["s3:ListBucket", "s3:GetObject"]
    resources = [
      "arn:aws:s3:::info-interview-project", 
      "arn:aws:s3:::info-interview-project/*"
    ]  # Replace with your bucket name
  }
}

# Attach the policy to the Lambda role
resource "aws_iam_policy_attachment" "lambda_policy_attachment" {
  name       = "lambda-s3-policy-attachment"
  policy_arn = aws_iam_policy.lambda_policy.arn
  roles      = [aws_iam_role.lambda_role.name]
}

# Lambda function creation
resource "aws_lambda_function" "lambda_function" {
  function_name = "list-bucket-content-function"
  filename      = "lambda.zip"  # Ensure this is the correct path to your Lambda zip file
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.12"  # Use Python 3.12 (update if necessary)
  environment {
    variables = {
      BUCKET_NAME = "info-interview-project"  # Replace with your bucket name
    }
  }
}

# API Gateway - REST API creation
resource "aws_api_gateway_rest_api" "api" {
  name        = "lambda-api"
  description = "API for invoking Lambda"
}

# Create a resource under the REST API
resource "aws_api_gateway_resource" "resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "list-bucket-content"
}

# Create a GET method for the resource
resource "aws_api_gateway_method" "method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.resource.id
  http_method   = "GET"
  authorization = "NONE"
}

# Integration between API Gateway and Lambda function
resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.resource.id
  http_method             = aws_api_gateway_method.method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${aws_lambda_function.lambda_function.arn}/invocations"
}

# Lambda permission to allow API Gateway to invoke it
resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  principal     = "apigateway.amazonaws.com"
  function_name = aws_lambda_function.lambda_function.function_name
}

# API Gateway Deployment
resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on = [aws_api_gateway_integration.integration]

  rest_api_id = aws_api_gateway_rest_api.api.id
}

# API Gateway Stage creation
resource "aws_api_gateway_stage" "stage" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  deployment_id = aws_api_gateway_deployment.api_deployment.id
  stage_name    = "prod"
}

# Output the API URL
output "api_url" {
  value = "https://${aws_api_gateway_rest_api.api.id}.execute-api.${var.region}.amazonaws.com/${aws_api_gateway_stage.stage.stage_name}/list-bucket-content"
}
