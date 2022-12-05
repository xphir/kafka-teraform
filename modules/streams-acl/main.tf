
terraform {
  required_providers {
    kafka = {
      source  = "Mongey/kafka"
      version = "0.5.1"
    }
  }
}
# Allow Streams to read the input topics:
## this could be multiple input topics, so we would need to handle that
resource "kafka_acl" "read_input" {
  for_each            = toset(var.input_topic_names)
  resource_name       = each.value
  resource_type       = "Topic"
  acl_principal       = var.principal_name
  acl_host            = "*"
  acl_operation       = "Read"
  acl_permission_type = "Allow"
}
# Allow Streams to write to the output topics:
## this could be multiple input topics, so we would need to handle that
resource "kafka_acl" "write_output" {
  for_each            = toset(var.output_topic_names)
  resource_name       = each.value
  resource_type       = "Topic"
  acl_principal       = var.principal_name
  acl_host            = "*"
  acl_operation       = "Write"
  acl_permission_type = "Allow"
}
# Allow Streams to manage its own internal topics:
resource "kafka_acl" "manage_internal" {
  for_each                     = toset(["Read", "Write", "Create", "Delete"])
  resource_name                = var.internal_topic_name
  resource_type                = "Topic"
  resource_pattern_type_filter = "Prefixed"
  acl_principal                = var.principal_name
  acl_host                     = "*"
  acl_operation                = each.value
  acl_permission_type          = "Allow"
}
# Allow Streams to manage its own consumer groups:
resource "kafka_acl" "manage_consumer_group" {
  for_each                     = toset(["Read", "Describe"])
  resource_name                = var.consumer_group_name
  resource_type                = "Group"
  resource_pattern_type_filter = "Prefixed"
  acl_principal                = var.principal_name
  acl_host                     = "*"
  acl_operation                = each.value
  acl_permission_type          = "Allow"
}
# Allow Streams EOS:
resource "kafka_acl" "allow_streams_eos" {
  for_each                     = toset(["Write", "Describe"])
  resource_name                = var.transactional_id_name
  resource_type                = "TransactionalID"
  resource_pattern_type_filter = "Prefixed"
  acl_principal                = var.principal_name
  acl_host                     = "*"
  acl_operation                = each.value
  acl_permission_type          = "Allow"
}



