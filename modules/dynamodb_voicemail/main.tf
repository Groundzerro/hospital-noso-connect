resource "aws_dynamodb_table" "voicemail" {
  name         = "${var.name_prefix}-voicemail"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "ContactId"

  attribute {
    name = "ContactId"
    type = "S"
  }

  tags = var.tags
}
