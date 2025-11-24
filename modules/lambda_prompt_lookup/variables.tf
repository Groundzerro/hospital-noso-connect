variable "name_prefix" { type = string }

variable "prompts_table_name" {
  type = string
}
variable "prompts_table_arn" {
  type = string
}

# where the python code lives
variable "lambda_source_dir" {
  type = string
  # default = "${path.root}/lambda/prompt_lookup"
}
