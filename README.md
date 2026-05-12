# terraform-oci-fk-drg

This repository contains a reusable **Terraform/OpenTofu module** and progressive examples for deploying **Oracle Cloud Infrastructure (OCI) Dynamic Routing Gateways (DRGs)** and related connectivity primitives such as **VCN attachments**, **DRG route tables**, and **Remote Peering Connections (RPCs)**.

It is part of the **[FoggyKitchen.com training ecosystem](https://foggykitchen.com/courses-2/)** and serves as the strategic OCI connectivity building block for remote peering, transit routing, and more advanced network designs.

---

## 🎯 Purpose

The goal of this module is to provide a **clean, composable, and educational reference implementation** for OCI DRG-based connectivity:

- Focused on **DRG resources and DRG-side routing constructs**
- No hidden VCN or subnet creation
- Designed to be composed with **terraform-oci-fk-vcn** and future OCI connectivity modules

This is **not** a full landing zone replacement. It is a **connectivity foundation module** intended for learning, reuse, and composition.

---

## ✨ What the module does

The module creates:

- OCI Dynamic Routing Gateway (DRG)
- Optional VCN attachments
- Optional Remote Peering Connections (RPCs)
- Optional DRG route tables
- Optional DRG route table route rules
- Optional RPC attachment management resources
- Optional VCN attachment to DRG route table associations

The module intentionally does **not** create:
- VCNs
- Subnets
- Internet Gateways
- NAT Gateways
- Service Gateways
- Compute instances

Each of those concerns belongs in its own dedicated module or composition layer.

---

## 📂 Repository Structure

```bash
terraform-oci-fk-drg/
├── examples/
│   ├── 01-basic-drg-vcn-attachment/
│   ├── 02-cross-region-drg-remote-peering/
│   ├── 03-drg-hub-spoke-transit-routing/
│   └── README.md
├── main.tf
├── variables.tf
├── outputs.tf
├── versions.tf
├── LICENSE
└── README.md
```

All examples are runnable and demonstrate how DRG-based connectivity composes with reusable VCN foundations.

---

## 🚀 Example Usage

```hcl
module "drg" {
  source = "git::https://github.com/mlinxfeld/terraform-oci-fk-drg.git?ref=v0.3.0"

  compartment_ocid = var.compartment_ocid
  name             = "fk-drg-demo"

  vcn_attachments = {
    app = {
      vcn_id              = module.vcn.vcn_id
      drg_route_table_key = "from-vcn"
    }
  }

  drg_route_tables = {
    from-vcn = {
      route_rules = []
    }
  }
}
```

In a complete deployment, VCN route tables should usually reference the DRG through `extra_network_entity_ids` inside **terraform-oci-fk-vcn**, while DRG-side route tables model the transit logic between attachments and remote connections.

---

## ⚙️ Module Inputs

### Core inputs

| Variable | Type | Required | Description |
|--------|------|----------|-------------|
| `compartment_ocid` | `string` | ✅ | Compartment OCID where DRG resources will be created |
| `name` | `string` | ✅ | Base name used for the DRG and related resources |
| `display_name` | `string` | ❌ | Optional DRG display name override |
| `defined_tags` | `map(string)` | ❌ | Defined tags |
| `freeform_tags` | `map(string)` | ❌ | Freeform tags |

### Connectivity objects

| Variable | Type | Required | Description |
|--------|------|----------|-------------|
| `vcn_attachments` | `map(object)` | ❌ | VCN attachments to create on the DRG |
| `remote_peering_connections` | `map(object)` | ❌ | RPCs to create on the DRG |
| `drg_route_tables` | `map(object)` | ❌ | DRG route tables and route rules |
| `rpc_attachment_managements` | `map(object)` | ❌ | RPC attachment management objects used for DRG route-table association |

### VCN attachment object schema

```hcl
vcn_attachments = map(object({
  vcn_id              = string
  display_name        = optional(string)
  drg_route_table_key = optional(string)
}))
```

### RPC object schema

```hcl
remote_peering_connections = map(object({
  compartment_ocid = optional(string)
  display_name     = optional(string)
  peer_id          = optional(string)
  peer_region_name = optional(string)
}))
```

### DRG route table object schema

```hcl
drg_route_tables = map(object({
  display_name = optional(string)
  route_rules = optional(list(object({
    destination                            = string
    destination_type                       = optional(string, "CIDR_BLOCK")
    next_hop_attachment_key                = optional(string)
    next_hop_rpc_attachment_management_key = optional(string)
    next_hop_drg_attachment_id             = optional(string)
  })), [])
}))
```

### RPC attachment management object schema

```hcl
rpc_attachment_managements = map(object({
  rpc_key             = string
  drg_route_table_key = string
  compartment_ocid    = optional(string)
  display_name        = optional(string)
}))
```

---

## 📤 Outputs

| Output | Description |
|------|-------------|
| `drg_id` | DRG OCID |
| `drg_name` | DRG display name |
| `drg_attachment_ids` | Map of VCN attachment keys to OCIDs |
| `drg_route_table_ids` | Map of DRG route table keys to OCIDs |
| `remote_peering_connection_ids` | Map of RPC keys to OCIDs |
| `rpc_attachment_management_ids` | Map of RPC attachment management keys to OCIDs |

---

## 🧩 Examples Overview

| Example | Description |
|-------|-------------|
| `01-basic-drg-vcn-attachment` | A reusable OCI VCN attached to a DRG, establishing the DRG foundation for later remote and transit connectivity examples |
| `02-cross-region-drg-remote-peering` | Two VCNs in different OCI regions connected through two DRGs and RPC-based remote peering |
| `03-drg-hub-spoke-transit-routing` | Three VCNs attached to one DRG, using DRG route tables to provide OCI-native hub-and-spoke transit routing |

See [`examples/`](examples) for details.

---

## 🧠 Design Philosophy

- Explicit over implicit
- Small modules over monoliths
- DRG connectivity separated from VCN foundation
- Optimized for **learning, reuse, and composition**

This makes the module useful for:
- OCI remote peering foundations
- Transit routing labs
- Hybrid and multicloud connectivity building blocks
- Progressive evolution beyond LPG-only designs

---

## 📌 Notes

- DRG is the strategic OCI connectivity primitive for advanced routing scenarios
- VCN route tables and DRG route tables are separate concerns and should stay modeled separately
- Remote peering and transit designs typically require both VCN-side routes and DRG-side routes
- This module focuses on OCI core DRG primitives rather than full opinionated transit topologies

---

## 🌐 Learn More

Visit [FoggyKitchen.com](https://foggykitchen.com/) for OCI, multicloud, and Terraform/OpenTofu learning resources.

---

## 🪪 License

Licensed under the **Universal Permissive License (UPL), Version 1.0**.  
See [LICENSE](LICENSE) for more details.
