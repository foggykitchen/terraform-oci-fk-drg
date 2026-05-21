variable "compartment_ocid" {
  description = "Compartment OCID where the DRG resources will be created."
  type        = string
}

variable "name" {
  description = "Base name used for the DRG and related resources."
  type        = string
}

variable "display_name" {
  description = "Optional display name override for the DRG."
  type        = string
  default     = null
}

variable "defined_tags" {
  description = "Defined tags applied to top-level resources created by the module."
  type        = map(string)
  default     = {}
}

variable "freeform_tags" {
  description = "Freeform tags applied to top-level resources created by the module."
  type        = map(string)
  default     = {}
}

variable "vcn_attachments" {
  description = "Map of VCN attachments to create on the DRG."
  type = map(object({
    vcn_id              = string
    display_name        = optional(string)
    drg_route_table_key = optional(string)
  }))
  default = {}
}

variable "remote_peering_connections" {
  description = "Map of Remote Peering Connections (RPCs) to create on the DRG."
  type = map(object({
    compartment_ocid = optional(string)
    display_name     = optional(string)
    peer_id          = optional(string)
    peer_region_name = optional(string)
  }))
  default = {}
}

variable "drg_route_tables" {
  description = "Map of DRG route tables and optional route rules."
  type = map(object({
    display_name                      = optional(string)
    import_drg_route_distribution_key = optional(string)
    route_rules = optional(list(object({
      destination                            = string
      destination_type                       = optional(string, "CIDR_BLOCK")
      next_hop_attachment_key                = optional(string)
      next_hop_rpc_attachment_management_key = optional(string)
      next_hop_drg_attachment_id             = optional(string)
    })), [])
  }))
  default = {}
}

variable "drg_route_distributions" {
  description = "Map of DRG route distributions and optional statements."
  type = map(object({
    distribution_type = string
    display_name      = optional(string)
    statements = optional(list(object({
      action   = string
      priority = number
      match_criteria = optional(list(object({
        match_type      = string
        attachment_type = optional(string)
      })), [])
    })), [])
  }))
  default = {}
}

variable "rpc_attachment_managements" {
  description = "Map of RPC attachment management resources used to associate RPCs with DRG route tables."
  type = map(object({
    rpc_key             = string
    drg_route_table_key = string
    compartment_ocid    = optional(string)
    display_name        = optional(string)
  }))
  default = {}
}

variable "default_route_table_managements" {
  description = "Map of default VCN route table management resources and route rules."
  type = map(object({
    manage_default_resource_id = string
    compartment_ocid           = optional(string)
    display_name               = optional(string)
    route_rules = optional(list(object({
      description        = optional(string)
      destination        = string
      destination_type   = optional(string, "CIDR_BLOCK")
      network_entity_id  = optional(string)
      network_entity_key = optional(string)
    })), [])
  }))
  default = {}
}
