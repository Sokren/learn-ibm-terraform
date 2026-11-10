##############################################################################
# Create a resource group or reuse an existing one
##############################################################################

resource "ibm_resource_group" "group" {
  count = var.existing_resource_group_name != "" ? 0 : 1
  name  = "${local.basename}-group"
  tags  = var.tags
}

data "ibm_resource_group" "group" {
  count = var.existing_resource_group_name != "" ? 1 : 0
  name  = var.existing_resource_group_name
}
