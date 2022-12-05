terraform {
  required_providers {
    kafka = {
      source  = "Mongey/kafka"
      version = "0.5.1"
    }
  }
}

provider "kafka" {
  bootstrap_servers = ["localhost:9092"]
  tls_enabled       = false
}

# locals {
#   internal_topic_operations = ["Read", "Write"]
# }
# resource "kafka_acl" "read_internal_topics" {
#   for_each            = toset(local.internal_topic_operations)
#   resource_name       = "syslog"
#   resource_type       = "Topic"
#   acl_principal       = "User:Alice"
#   acl_host            = "*"
#   acl_operation       = each.value
#   acl_permission_type = "Deny"
# }

module "streams-acl" {
  source                = "./modules/streams-acl"
  input_topic_names     = ["input-test-a", "input-test-b"]
  output_topic_names    = ["output-test"]
  internal_topic_name   = "internal-test"
  consumer_group_name   = "cg-test"
  transactional_id_name = "transaction-test"
  principal_name        = "User:test-name"
}

# resource "kafka_topic" "logs" {
#   name               = "systemd_logs"
#   replication_factor = 1
#   partitions         = 6

#   config = {
#     "segment.ms"     = "20000"
#     "cleanup.policy" = "compact"
#   }
# }
