data "archive_file" "zip" {
  type        = "zip"
  source_dir  = var.lambda_source_dir
  output_path = "${path.module}/prompt_lookup.zip"
}

resource "aws_iam_role" "lambda_role" {
  name = "${var.name_prefix}-prompt-lookup-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = { Service = "lambda.amazonaws.com" },
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "basic_logs" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "ddb_read" {
  name = "${var.name_prefix}-prompt-ddb-read"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = [
        "dynamodb:GetItem",
        "dynamodb:Query",
        "dynamodb:Scan"
      ],
      Resource = var.prompts_table_arn
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ddb_read_attach" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.ddb_read.arn
}

resource "aws_lambda_function" "prompt_lookup" {
  function_name = "${var.name_prefix}-prompt-lookup"
  role          = aws_iam_role.lambda_role.arn
  handler       = "app.lambda_handler"
  runtime       = "python3.12"
  filename      = data.archive_file.zip.output_path
  timeout       = 5

  environment {
    variables = {
      PROMPTS_TABLE = var.prompts_table_name
    }
  }
}


# resource "aws_iam_role" "lambda_role" {
#   name = "${var.name_prefix}-prompt-lookup-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [{
#       Effect = "Allow",
#       Principal = { Service = "lambda.amazonaws.com" },
#       Action = "sts:AssumeRole"
#     }]
#   })
# }

# resource "aws_iam_role_policy_attachment" "basic_logs" {
#   role       = aws_iam_role.lambda_role.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
# }

# resource "aws_iam_policy" "ddb_read" {
#   name = "${var.name_prefix}-prompt-ddb-read"

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [{
#       Effect = "Allow",
#       Action = [
#         "dynamodb:GetItem",
#         "dynamodb:Query",
#         "dynamodb:Scan"
#       ],
#       Resource = var.prompts_table_arn
#     }]
#   })
# }

# resource "aws_iam_role_policy_attachment" "ddb_read_attach" {
#   role       = aws_iam_role.lambda_role.name
#   policy_arn = aws_iam_policy.ddb_read.arn
# }
