output "vcn_id" {
  description = "VCN OCID."
  value       = module.vcn.vcn_id
}

output "drg_id" {
  description = "DRG OCID."
  value       = module.drg.drg_id
}

output "drg_attachment_ids" {
  description = "DRG attachment IDs."
  value       = module.drg.drg_attachment_ids
}

output "drg_route_table_ids" {
  description = "DRG route table IDs."
  value       = module.drg.drg_route_table_ids
}
