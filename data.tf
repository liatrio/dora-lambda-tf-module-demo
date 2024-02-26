data "archive_file" "python_lambda_package" {
  type        = "zip"
  source_file = "./src/lambda_function.py"
  output_path = "lambda_function.zip"
}