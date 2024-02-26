# dora-lambda-tf-module-demo

A Lambda Terraform Module repository for the DORA metrics demo.

To get started with DORA metrics, see this [OpenTelemetry DORA Demo][oteldora]
instructions.

[oteldora]: https://github.com/liatrio/opentelemetry-demo/blob/main/docs/delivery.md#github-app-setup-for-webhook-events

## Table Of Contents

1. [Prereqs](#prerequisites)
2. [Structure](#project-structure)
3. [Getting Started](#getting-started)
4. [Module Documentation](#terraform-module-documentation)

---

## Prerequisites

1. Terraform >= 0.14 (Specify the exact version in `versions.tf`)
2. AWS CLI installed and configured
3. Git
4. [pre-commit](https://pre-commit.com/#install)
5. [tflint](https://github.com/terraform-linters/tflint)
6. [tfsec](https://github.com/tfsec/tfsec)

## Project Structure

The project follows this directory structure:

```
project-root/
├── README.md
├── main.tf
├── providers.tf
├── variables.tf
├── outputs.tf
├── versions.tf
├── .pre-commit-config.yaml
├── modules/
│   ├── lambda_func/
│   │   ├── lambda.tf
│   │   ├── variables.tf
│   │   ├── api_gw.tf
│   │   ├── data.tf
│   │   ├── versions.tf
│   │   ├── vpc.tf
│   │   └── outputs.tf
│   └── ...
```

- `main.tf`: This file contains the module that Terraform will deploy -
  essentially everything contained in /modules/lambda_func.
- `lambda.tf`: This file contains the Lambda portion of the configuration and
  associated permissions in IAM.
- `vpc.tf`: This file contains the VPC configuration to deploy Lambda in a
  private subnet.
- `api_gw.tf`: This file contains the API Gateway configuration to expose the
  REST API for Lambda.
- `provider.tf`: This file defines the provider and required version.
- `variables.tf`: This file defines variables used in the Terraform
  configuration.
- `outputs.tf`: This file defines any outputs from your Terraform project.
- `.pre-commit-config.yaml`: This file contains configurations for pre-commit
  hooks.
- `code/.lambda_function.py`: This file contains the python code that returns a
  "Hello World" message.


## Instructions

### 1. Clone the Repository

First, clone this repository to your local machine.

```bash
git clone <repository_url>
```

### 2. Install pre-commit Hooks

Install the pre-commit hooks defined in `.pre-commit-config.yaml`.

```bash
pre-commit install
```

### 3. Initialize Terraform

Navigate to the `project-root/` directory and initialize Terraform.

```bash
cd project-root/
terraform init
```

### 4. Configure Variables

Open `variables.tf` and configure the necessary variables. You can also create
a `terraform.tfvars` file to set these values.

### 5. Plan and Apply

Run a plan to ensure everything looks good.

```bash
terraform plan
```

If the plan looks good, apply it.

```bash
terraform apply
```

You'll be prompted to confirm that you want to create the resources defined in
your `main.tf` file. Type `yes` to proceed.

### 6. Outputs

After `terraform apply` completes, you'll see outputs defined in `outputs.tf`.

You can curl the `invoke_url` output to receive a "Hello World" message.

### 7. Cleanup

After you are done using the infrastructure or want to start over, run the
following command to destroy all the resources created by Terraform:

```bash
terraform destroy
```

## Usage of Modules

Modules in the `modules/` directory can be used by referring to their path in
the `main.tf` file. For example, to use the `lambda_func` module:

```hcl
module "lambda_hello_world" {
  source = "./modules/lambda_func"
  // Variables specific to the lambda_func module
}
```

## Pre-Commit Hooks

This repository uses pre-commit hooks to run `terraform fmt`, `terraform
validate` before each commit. These hooks ensure that your Terraform files are
correctly formatted and validated.

### To Run Hooks Manually

You can also manually run the pre-commit hooks with the following command:

```bash
pre-commit run --all-files
```

### To Skip Hooks

You can skip pre-commit hooks with the follow command:

```bash
git commit --no-verify -m "your commit message"
```

## Terraform Module Documentation

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | >= 2.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.66 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.2.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | 2.4.2 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.38.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_api_gateway_deployment.api_deployment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_deployment) | resource |
| [aws_api_gateway_integration.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_integration) | resource |
| [aws_api_gateway_integration.lambda_root](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_integration) | resource |
| [aws_api_gateway_method.proxy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method) | resource |
| [aws_api_gateway_method.proxy_root](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method) | resource |
| [aws_api_gateway_resource.proxy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_resource) | resource |
| [aws_api_gateway_rest_api.api_gw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_rest_api) | resource |
| [aws_iam_policy.lambda_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.lambda_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.lambda_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.test_hello_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.apigw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_security_group.lambda_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.lambda_pvt_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.lambda_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [null_resource.function_binary](https://registry.terraform.io/providers/hashicorp/null/3.2.2/docs/resources/resource) | resource |
| [archive_file.function_archive](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | n/a | `string` | `"us-east-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_binary_path"></a> [binary\_path](#output\_binary\_path) | n/a |
| <a name="output_invoke_url"></a> [invoke\_url](#output\_invoke\_url) | n/a |
| <a name="output_lambda_arn"></a> [lambda\_arn](#output\_lambda\_arn) | n/a |
<!-- END_TF_DOCS -->
