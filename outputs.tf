output "drg_id" {
  description = "DRG OCID."
  value       = oci_core_drg.this.id
}

output "drg_name" {
  description = "DRG display name."
  value       = oci_core_drg.this.display_name
}

output "drg_attachment_ids" {
  description = "Map of VCN attachment keys to DRG attachment OCIDs."
  value = {
    for key, attachment in oci_core_drg_attachment.this : key => attachment.id
  }
}

output "drg_route_table_ids" {
  description = "Map of DRG route table keys to DRG route table OCIDs."
  value = {
    for key, table in oci_core_drg_route_table.this : key => table.id
  }
}

output "remote_peering_connection_ids" {
  description = "Map of RPC keys to Remote Peering Connection OCIDs."
  value = {
    for key, rpc in oci_core_remote_peering_connection.this : key => rpc.id
  }
}

output "rpc_attachment_management_ids" {
  description = "Map of RPC attachment management keys to OCIDs."
  value = {
    for key, attachment in oci_core_drg_attachment_management.rpc : key => attachment.id
  }
}
