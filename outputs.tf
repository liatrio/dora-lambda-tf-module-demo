output "lambda_arn" {
  value = aws_lambda_function.test_hello_lambda.arn
}

output "invoke_url" {
  value = aws_api_gateway_deployment.api_deployment.invoke_url
}