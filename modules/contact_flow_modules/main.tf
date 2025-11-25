resource "aws_connect_contact_flow_module" "module" {
  for_each    = var.modules
  instance_id = var.instance_id
  name        = "${var.name_prefix}-${each.key}"
  description = each.value.description
  content     = file("${path.root}/${each.value.file_path}")

  lifecycle {
    prevent_destroy = true
  }
}


# resource "aws_connect_contact_flow_module" "module" {
#   for_each = var.modules

#   instance_id = var.instance_id
#   name        = "${var.name_prefix}-${each.key}"
#   description = each.value.description
#   content     = file(each.value.file_path)
# }


# resource "aws_connect_contact_flow" "module" {
#   for_each = var.modules

#   instance_id = var.instance_id
#   name        = "${var.name_prefix}-${each.key}"
#   description = each.value.description
#   # type        = "CONTACT_FLOW_MODULE"
#   content = file(each.value.file_path)
# }


# This style is better for brand new flows because it will create a brand new Flow ID

# resource "terraform_data" "module_file_hash" {
#   for_each = var.modules
#   input    = filesha256(each.value.file_path)
# }

# resource "aws_connect_contact_flow" "module" {
#   for_each = var.modules

#   instance_id = var.instance_id
#   name        = "${var.name_prefix}-${each.key}"
#   description = each.value.description
#   # type        = "CONTACT_FLOW_MODULE"
#   content     = file(each.value.file_path)

#   lifecycle {
#     replace_triggered_by = [
#       terraform_data.module_file_hash[each.key]
#     ]
#   }
# }

