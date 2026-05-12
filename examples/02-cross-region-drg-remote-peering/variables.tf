variable "tenancy_ocid" {
  description = "OCI tenancy OCID."
  type        = string
}

variable "user_ocid" {
  description = "OCI user OCID."
  type        = string
}

variable "fingerprint" {
  description = "API key fingerprint."
  type        = string
}

variable "private_key_path" {
  description = "Path to the OCI API private key."
  type        = string
}

variable "home_region" {
  description = "Primary OCI region for the first VCN and DRG."
  type        = string
}

variable "peer_region" {
  description = "Secondary OCI region for the second VCN and DRG."
  type        = string
}

variable "compartment_ocid" {
  description = "Compartment OCID used for all resources in the example."
  type        = string
}
