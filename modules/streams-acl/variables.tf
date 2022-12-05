variable "input_topic_names" {
  description = "A list of input topics. must be unique"
  type        = list(string)
  default     = null
}
variable "output_topic_names" {
  description = "A list of output topics. must be unique"
  type        = list(string)
  default     = null
}
variable "internal_topic_name" {
  description = "TODO"
  type        = string
  default     = null
}
variable "consumer_group_name" {
  description = "TODO"
  type        = string
  default     = null
}
variable "transactional_id_name" {
  description = "TODO"
  type        = string
  default     = null
}
variable "principal_name" {
  description = "TODO"
  type        = string
  default     = null
}
