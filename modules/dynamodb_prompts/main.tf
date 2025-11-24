resource "aws_dynamodb_table" "prompts" {
  name         = "${var.name_prefix}-prompts"
  billing_mode = "PAY_PER_REQUEST" # on-demand
  hash_key     = "PromptKey"

  attribute {
    name = "PromptKey"
    type = "S"
  }

  tags = var.tags
}
