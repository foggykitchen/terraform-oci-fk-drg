# OCI Dynamic Routing Gateway with Terraform/OpenTofu - Training Examples

This directory contains runnable examples for the **terraform-oci-fk-drg** module.
The examples focus on practical Oracle Cloud Infrastructure (OCI) Dynamic Routing Gateway deployment patterns for foundational connectivity and routing composition.

These examples are part of the **[FoggyKitchen.com training ecosystem](https://foggykitchen.com/courses-2/)** and are used across OCI and multicloud courses covering networking, connectivity composition, and architecture fundamentals.

---

## Published Examples

| Example | Title | Key Topics |
|:-------:|:------|:-----------|
| 01 | **Basic DRG VCN Attachment** | one VCN, one DRG, VCN attachment, DRG route table composition, `terraform-oci-fk-vcn` integration |
| 02 | **Cross-Region DRG Remote Peering** | two VCNs, two DRGs, two regions, RPC peering, VCN route tables, DRG route tables, `terraform-oci-fk-vcn` integration |

---

## How to Use

The example directory contains:
- Terraform/OpenTofu configuration (`.tf`)
- A focused `README.md` explaining the goal of the example
- A minimal, runnable architecture

To run the basic DRG VCN attachment example:

```bash
cd examples/01-basic-drg-vcn-attachment
cp terraform.tfvars.example terraform.tfvars
tofu init
tofu plan
tofu apply
```

To run the cross-region DRG remote peering example:

```bash
cd examples/02-cross-region-drg-remote-peering
cp terraform.tfvars.example terraform.tfvars
tofu init
tofu plan
tofu apply
```

---

## Design Principles

- One example = one architectural goal
- No unused or placeholder resources
- Clear separation of concerns between network foundation and connectivity composition
- Examples designed to integrate with reusable VCN modules rather than reimplementing VCN internals

---

## Related Resources

- [FoggyKitchen OCI Dynamic Routing Gateway Module (terraform-oci-fk-drg)](../)
- [FoggyKitchen OCI VCN Module (terraform-oci-fk-vcn)](https://github.com/mlinxfeld/terraform-oci-fk-vcn)
- [FoggyKitchen OCI Compute Module (terraform-oci-fk-compute)](https://github.com/mlinxfeld/terraform-oci-fk-compute)
- [FoggyKitchen OCI Local Peering Gateway Module (terraform-oci-fk-lpg)](https://github.com/mlinxfeld/terraform-oci-fk-lpg)

---

## License

Licensed under the **Universal Permissive License (UPL), Version 1.0**.
See [LICENSE](../LICENSE) for details.

---

© 2026 FoggyKitchen.com - Cloud. Code. Clarity.
