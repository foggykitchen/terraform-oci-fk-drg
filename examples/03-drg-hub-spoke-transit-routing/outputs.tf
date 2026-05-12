output "hub_vcn_id" {
  description = "Hub VCN OCID."
  value       = module.vcn_hub.vcn_id
}

output "spoke1_vcn_id" {
  description = "Spoke1 VCN OCID."
  value       = module.vcn_spoke1.vcn_id
}

output "spoke2_vcn_id" {
  description = "Spoke2 VCN OCID."
  value       = module.vcn_spoke2.vcn_id
}

output "drg_id" {
  description = "Hub DRG OCID."
  value       = module.drg_hub.drg_id
}

output "drg_attachment_ids" {
  description = "DRG attachment IDs."
  value       = module.drg_hub.drg_attachment_ids
}

output "drg_route_table_ids" {
  description = "DRG route table IDs."
  value       = module.drg_hub.drg_route_table_ids
}
