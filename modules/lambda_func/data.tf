data "archive_file" "python_lambda_package" {
  type        = "zip"
  source_file = "${path.module}/code/lambda_function.py"
  output_path = "lambda_function.zip"
}