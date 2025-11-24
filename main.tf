locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

module "hours" {
  source      = "./modules/hours_of_operation"
  instance_id = var.instance_id
  name        = "${local.name_prefix}-${var.hours_of_operation.name}"
  time_zone   = var.time_zone

  config = var.hours_of_operation.config
}

module "queues" {
  source                = "./modules/queues"
  instance_id           = var.instance_id
  hours_of_operation_id = module.hours.hours_id
  queues                = var.queues
  name_prefix           = local.name_prefix
}

module "routing_profiles" {
  source           = "./modules/routing_profiles"
  instance_id      = var.instance_id
  name_prefix      = local.name_prefix
  routing_profiles = var.routing_profiles
  queue_ids        = module.queues.queue_ids
}

module "flow_modules" {
  source      = "./modules/contact_flow_modules"
  instance_id = var.instance_id
  name_prefix = local.name_prefix
  modules     = var.flow_modules

  # ensure queues exist if modules reference them
  depends_on = [module.queues]
}

module "contact_flows" {
  source      = "./modules/contact_flows"
  instance_id = var.instance_id
  name_prefix = local.name_prefix
  flows       = var.contact_flows
  queue_ids   = module.queues.queue_ids
  module_arns = module.flow_modules.module_arns

  depends_on = [module.flow_modules]
}

# Prompts/config DynamoDB table
module "prompts_table" {
  source      = "./modules/dynamodb_prompts"
  name_prefix = local.name_prefix
}

# Voicemail metadata DynamoDB table
module "voicemail_table" {
  source      = "./modules/dynamodb_voicemail"
  name_prefix = local.name_prefix
}

# Voicemail audio S3 bucket
module "voicemail_bucket" {
  source      = "./modules/s3_voicemail"
  name_prefix = local.name_prefix
}

# Lambda that looks up prompts
module "prompt_lookup_lambda" {
  source             = "./modules/lambda_prompt_lookup"
  name_prefix        = local.name_prefix
  prompts_table_name = module.prompts_table.table_name
  prompts_table_arn  = module.prompts_table.table_arn

  # optional override if you move code later
  lambda_source_dir = "${path.root}/lambda/prompt_lookup"
}


# module "prompt_lookup_lambda" {
#   source             = "./modules/lambda_prompt_lookup"
#   name_prefix        = local.name_prefix
#   prompts_table_name = module.prompts_table.table_name
#   prompts_table_arn  = module.prompts_table.table_arn
# }

