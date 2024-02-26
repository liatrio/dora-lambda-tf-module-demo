output "lambda_arn" {
  value = module.hello-world-lambda.lambda_arn
}

output "invoke_url" {
  value = module.hello-world-lambda.invoke_url
}