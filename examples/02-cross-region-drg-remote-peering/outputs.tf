output "home_vcn_id" {
  description = "Home-region VCN OCID."
  value       = module.vcn_home.vcn_id
}

output "peer_vcn_id" {
  description = "Peer-region VCN OCID."
  value       = module.vcn_peer.vcn_id
}

output "home_drg_id" {
  description = "Home-region DRG OCID."
  value       = module.drg_home.drg_id
}

output "peer_drg_id" {
  description = "Peer-region DRG OCID."
  value       = module.drg_peer.drg_id
}

output "home_drg_attachment_ids" {
  description = "Home-region DRG attachment IDs."
  value       = module.drg_home.drg_attachment_ids
}

output "peer_drg_attachment_ids" {
  description = "Peer-region DRG attachment IDs."
  value       = module.drg_peer.drg_attachment_ids
}

output "home_drg_route_table_ids" {
  description = "Home-region DRG route table IDs."
  value       = module.drg_home.drg_route_table_ids
}

output "peer_drg_route_table_ids" {
  description = "Peer-region DRG route table IDs."
  value       = module.drg_peer.drg_route_table_ids
}

output "home_remote_peering_connection_ids" {
  description = "Home-region RPC IDs."
  value       = module.drg_home.remote_peering_connection_ids
}

output "peer_remote_peering_connection_ids" {
  description = "Peer-region RPC IDs."
  value       = module.drg_peer.remote_peering_connection_ids
}
