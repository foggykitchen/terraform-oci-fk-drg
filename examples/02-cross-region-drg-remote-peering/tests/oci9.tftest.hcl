# Synthetic fixtures only. Every run is plan-only; no tenancy credentials are used.
mock_provider "oci" {
  mock_data "oci_core_services" {
    defaults = { "id" = "MOCK_OCID_SERVICES", "services" = [{ "cidr_block" = "all-fra-services-in-oracle-services-network", "description" = "mock-value", "id" = "mock-service", "name" = "All FRA Services In Oracle Services Network" }] }
  }
  mock_resource "oci_core_default_route_table" {
    defaults = { "id" = "MOCK_OCID_TABLE", "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_dhcp_options" {
    defaults = { "id" = "MOCK_OCID_OPTIONS", "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_drg" {
    defaults = { "default_drg_route_tables" = [{ "ipsec_tunnel" = "mock-value", "remote_peering_connection" = "mock-value", "vcn" = "mock-value", "virtual_circuit" = "mock-value" }], "default_export_drg_route_distribution_id" = "MOCK_OCID_MOCK", "id" = "MOCK_OCID_DRG", "redundancy_status" = "mock-value", "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_drg_attachment" {
    defaults = { "compartment_id" = "MOCK_OCID_COMPARTMENT", "id" = "MOCK_OCID_ATTACHMENT", "is_cross_tenancy" = false, "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_drg_attachment_management" {
    defaults = { "id" = "MOCK_OCID_MANAGEMENT", "is_cross_tenancy" = false, "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_drg_route_distribution" {
    defaults = { "compartment_id" = "MOCK_OCID_COMPARTMENT", "id" = "MOCK_OCID_DISTRIBUTION", "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_drg_route_distribution_statement" {
    defaults = { "id" = "MOCK_OCID_STATEMENT" }
  }
  mock_resource "oci_core_drg_route_table" {
    defaults = { "compartment_id" = "MOCK_OCID_COMPARTMENT", "id" = "MOCK_OCID_TABLE", "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_drg_route_table_route_rule" {
    defaults = { "attributes" = {}, "id" = "MOCK_OCID_RULE", "is_blackhole" = false, "is_conflict" = false, "route_provenance" = "mock-value", "route_type" = "mock-value" }
  }
  mock_resource "oci_core_internet_gateway" {
    defaults = { "id" = "MOCK_OCID_GATEWAY", "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_nat_gateway" {
    defaults = { "id" = "MOCK_OCID_GATEWAY", "nat_ip" = "mock-value", "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_remote_peering_connection" {
    defaults = { "id" = "MOCK_OCID_CONNECTION", "is_cross_tenancy_peering" = false, "peer_tenancy_id" = "MOCK_OCID_MOCK", "peering_status" = "mock-value", "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_route_table" {
    defaults = { "id" = "MOCK_OCID_TABLE", "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_security_list" {
    defaults = { "id" = "MOCK_OCID_LIST", "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_service_gateway" {
    defaults = { "block_traffic" = false, "id" = "MOCK_OCID_GATEWAY", "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_subnet" {
    defaults = { "id" = "MOCK_OCID_SUBNET", "ipv6virtual_router_ip" = "mock-value", "state" = "AVAILABLE", "subnet_domain_name" = "mock-value", "time_created" = "mock-value", "virtual_router_ip" = "mock-value", "virtual_router_mac" = "mock-value" }
  }
  mock_resource "oci_core_vcn" {
    defaults = { "byoipv6cidr_blocks" = ["mock-value"], "default_dhcp_options_id" = "MOCK_OCID_MOCK", "default_route_table_id" = "MOCK_OCID_MOCK", "default_security_list_id" = "MOCK_OCID_MOCK", "id" = "MOCK_OCID_VCN", "ipv6cidr_blocks" = ["mock-value"], "state" = "AVAILABLE", "time_created" = "mock-value", "vcn_domain_name" = "mock-value" }
  }
}
mock_provider "oci" {
  alias = "peer"
  mock_data "oci_core_services" {
    defaults = { "id" = "MOCK_OCID_SERVICES", "services" = [{ "cidr_block" = "all-fra-services-in-oracle-services-network", "description" = "mock-value", "id" = "mock-service", "name" = "All FRA Services In Oracle Services Network" }] }
  }
  mock_resource "oci_core_default_route_table" {
    defaults = { "id" = "MOCK_OCID_TABLE", "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_dhcp_options" {
    defaults = { "id" = "MOCK_OCID_OPTIONS", "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_drg" {
    defaults = { "default_drg_route_tables" = [{ "ipsec_tunnel" = "mock-value", "remote_peering_connection" = "mock-value", "vcn" = "mock-value", "virtual_circuit" = "mock-value" }], "default_export_drg_route_distribution_id" = "MOCK_OCID_MOCK", "id" = "MOCK_OCID_DRG", "redundancy_status" = "mock-value", "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_drg_attachment" {
    defaults = { "compartment_id" = "MOCK_OCID_COMPARTMENT", "id" = "MOCK_OCID_ATTACHMENT", "is_cross_tenancy" = false, "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_drg_attachment_management" {
    defaults = { "id" = "MOCK_OCID_MANAGEMENT", "is_cross_tenancy" = false, "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_drg_route_distribution" {
    defaults = { "compartment_id" = "MOCK_OCID_COMPARTMENT", "id" = "MOCK_OCID_DISTRIBUTION", "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_drg_route_distribution_statement" {
    defaults = { "id" = "MOCK_OCID_STATEMENT" }
  }
  mock_resource "oci_core_drg_route_table" {
    defaults = { "compartment_id" = "MOCK_OCID_COMPARTMENT", "id" = "MOCK_OCID_TABLE", "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_drg_route_table_route_rule" {
    defaults = { "attributes" = {}, "id" = "MOCK_OCID_RULE", "is_blackhole" = false, "is_conflict" = false, "route_provenance" = "mock-value", "route_type" = "mock-value" }
  }
  mock_resource "oci_core_internet_gateway" {
    defaults = { "id" = "MOCK_OCID_GATEWAY", "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_nat_gateway" {
    defaults = { "id" = "MOCK_OCID_GATEWAY", "nat_ip" = "mock-value", "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_remote_peering_connection" {
    defaults = { "id" = "MOCK_OCID_CONNECTION", "is_cross_tenancy_peering" = false, "peer_tenancy_id" = "MOCK_OCID_MOCK", "peering_status" = "mock-value", "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_route_table" {
    defaults = { "id" = "MOCK_OCID_TABLE", "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_security_list" {
    defaults = { "id" = "MOCK_OCID_LIST", "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_service_gateway" {
    defaults = { "block_traffic" = false, "id" = "MOCK_OCID_GATEWAY", "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_subnet" {
    defaults = { "id" = "MOCK_OCID_SUBNET", "ipv6virtual_router_ip" = "mock-value", "state" = "AVAILABLE", "subnet_domain_name" = "mock-value", "time_created" = "mock-value", "virtual_router_ip" = "mock-value", "virtual_router_mac" = "mock-value" }
  }
  mock_resource "oci_core_vcn" {
    defaults = { "byoipv6cidr_blocks" = ["mock-value"], "default_dhcp_options_id" = "MOCK_OCID_MOCK", "default_route_table_id" = "MOCK_OCID_MOCK", "default_security_list_id" = "MOCK_OCID_MOCK", "id" = "MOCK_OCID_VCN", "ipv6cidr_blocks" = ["mock-value"], "state" = "AVAILABLE", "time_created" = "mock-value", "vcn_domain_name" = "mock-value" }
  }
}
variables {
  tenancy_ocid     = "MOCK_OCID_TENANCY"
  user_ocid        = "MOCK_OCID_MOCK"
  fingerprint      = "compatibility"
  private_key_path = "/unused-by-mock"
  home_region      = "eu-frankfurt-1"
  peer_region      = "eu-amsterdam-1"
  compartment_ocid = "MOCK_OCID_COMPARTMENT"
}

run "oci9_plan" {
  command   = plan
  providers = { oci = oci, oci.peer = oci.peer }
}
