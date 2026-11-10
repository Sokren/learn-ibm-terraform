resource "random_string" "random" {
  count = var.prefix == "" ? 1 : 0

  length  = 6
  special = false
}

locals {
  basename          = lower(var.prefix == "" ? "learn-${random_string.random[0].result}" : var.prefix)
  resource_group_id = var.existing_resource_group_name != "" ? data.ibm_resource_group.group[0].id : ibm_resource_group.group[0].id
}
