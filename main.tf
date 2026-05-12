locals {
  route_rules = length(var.drg_route_tables) == 0 ? {} : merge([
    for table_key, table in var.drg_route_tables : {
      for idx, rule in try(table.route_rules, []) : "${table_key}-${idx}" => merge(rule, {
        drg_route_table_key = table_key
      })
    }
  ]...)
}

resource "oci_core_drg" "this" {
  compartment_id = var.compartment_ocid
  display_name   = coalesce(var.display_name, var.name)

  defined_tags  = var.defined_tags
  freeform_tags = var.freeform_tags
}

resource "oci_core_drg_attachment" "this" {
  for_each = var.vcn_attachments

  drg_id             = oci_core_drg.this.id
  vcn_id             = each.value.vcn_id
  drg_route_table_id = try(each.value.drg_route_table_key, null) != null ? oci_core_drg_route_table.this[each.value.drg_route_table_key].id : null
  display_name       = coalesce(try(each.value.display_name, null), "${var.name}-${each.key}-attachment")

  defined_tags  = var.defined_tags
  freeform_tags = var.freeform_tags
}

resource "oci_core_remote_peering_connection" "this" {
  for_each = var.remote_peering_connections

  compartment_id   = coalesce(try(each.value.compartment_ocid, null), var.compartment_ocid)
  drg_id           = oci_core_drg.this.id
  display_name     = coalesce(try(each.value.display_name, null), "${var.name}-${each.key}-rpc")
  peer_id          = try(each.value.peer_id, null)
  peer_region_name = try(each.value.peer_region_name, null)

  defined_tags  = var.defined_tags
  freeform_tags = var.freeform_tags
}

resource "oci_core_drg_route_table" "this" {
  for_each = var.drg_route_tables

  drg_id       = oci_core_drg.this.id
  display_name = coalesce(try(each.value.display_name, null), "${var.name}-${each.key}")

  defined_tags  = var.defined_tags
  freeform_tags = var.freeform_tags
}

resource "oci_core_drg_attachment_management" "rpc" {
  for_each = var.rpc_attachment_managements

  compartment_id     = coalesce(try(each.value.compartment_ocid, null), var.compartment_ocid)
  attachment_type    = "REMOTE_PEERING_CONNECTION"
  display_name       = coalesce(try(each.value.display_name, null), "${var.name}-${each.key}-attachment-management")
  network_id         = oci_core_remote_peering_connection.this[each.value.rpc_key].id
  drg_id             = oci_core_drg.this.id
  drg_route_table_id = oci_core_drg_route_table.this[each.value.drg_route_table_key].id
}

resource "oci_core_drg_route_table_route_rule" "this" {
  for_each = local.route_rules

  drg_route_table_id = oci_core_drg_route_table.this[each.value.drg_route_table_key].id
  destination        = each.value.destination
  destination_type   = try(each.value.destination_type, "CIDR_BLOCK")
  next_hop_drg_attachment_id = try(each.value.next_hop_drg_attachment_id, null) != null ? each.value.next_hop_drg_attachment_id : (
    try(each.value.next_hop_attachment_key, null) != null ? oci_core_drg_attachment.this[each.value.next_hop_attachment_key].id : oci_core_drg_attachment_management.rpc[each.value.next_hop_rpc_attachment_management_key].id
  )
}
