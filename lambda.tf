#tfsec:ignore:aws-ec2-no-public-egress-sgr
resource "aws_security_group" "lambda_sg" {
  name_prefix = "test-lambda-sg"
  vpc_id      = aws_vpc.lambda_vpc.id
  description = "default test-lambda security group"

  // Open ephemeral ports
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
    description = "Allow ingress from VPC"
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow egress everywhere"
  }
}

resource "aws_iam_role" "lambda_role" {
  name = "test-lambda-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

#tfsec:ignore:aws-iam-no-policy-wildcards
resource "aws_iam_policy" "lambda_policy" {
  name = "test-lambda-policy"
  // Minimum permissions for Lambda to stream logs
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
      Resource = ["arn:aws:logs:*:*:*"]
      }, {
      Effect = "Allow"
      Action = [
        "ec2:CreateNetworkInterface",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DeleteNetworkInterface"
      ]
      Resource = ["*"]
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  policy_arn = aws_iam_policy.lambda_policy.arn
  role       = aws_iam_role.lambda_role.name
}

resource "null_resource" "function_binary" {
  provisioner "local-exec" {
    command = "GOOS=linux GOARCH=amd64 CGO_ENABLED=0 GOFLAGS=-trimpath go build -mod=readonly -ldflags='-s -w' -o ${local.binary_path} ${local.src_path}"
  }
}

data "archive_file" "function_archive" {
  depends_on  = [null_resource.function_binary]
  type        = "zip"
  source_file = local.binary_path
  output_path = local.archive_path
}

#tfsec:ignore:aws-lambda-enable-tracing
resource "aws_lambda_function" "test_hello_lambda" {
  function_name    = local.function_name
  filename         = local.archive_path
  source_code_hash = data.archive_file.function_archive.output_base64sha256
  role             = aws_iam_role.lambda_role.arn
  handler          = local.binary_name
  memory_size      = 128
  runtime          = "go1.x"
  vpc_config {
    subnet_ids         = [aws_subnet.lambda_pvt_subnet.id]
    security_group_ids = [aws_security_group.lambda_sg.id]
  }
}
