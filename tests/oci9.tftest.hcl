# Synthetic fixtures only. Every run is plan-only; no tenancy credentials are used.
mock_provider "oci" {
  mock_resource "oci_core_default_route_table" {
    defaults = { "id" = "MOCK_OCID_TABLE", "state" = "AVAILABLE", "time_created" = "mock-value" }
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
  mock_resource "oci_core_remote_peering_connection" {
    defaults = { "id" = "MOCK_OCID_CONNECTION", "is_cross_tenancy_peering" = false, "peer_tenancy_id" = "MOCK_OCID_MOCK", "peering_status" = "mock-value", "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
}
variables {
  compartment_ocid = "MOCK_OCID_COMPARTMENT"
  name             = "compatibility"
}

run "oci9_plan" {
  command = plan
}
