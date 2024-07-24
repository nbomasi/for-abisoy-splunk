variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table for state locking"
  type        = string
  default     = "terraform-state-locks"
}

variable "tags" {
  description = "Tags for the DynamoDB table"
  type        = map(string)
  default     = {}
}
