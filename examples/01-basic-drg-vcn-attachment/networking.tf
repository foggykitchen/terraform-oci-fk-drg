module "vcn" {
  source = "git::https://github.com/foggykitchen/terraform-oci-fk-vcn.git"

  compartment_ocid = var.compartment_ocid
  name             = "fk-drg-vcn"
  vcn_cidr_blocks  = ["10.30.0.0/16"]

  create_nat_gateway     = true
  create_service_gateway = true

  route_tables = {
    private = {
      route_rules = [
        {
          destination        = "0.0.0.0/0"
          destination_type   = "CIDR_BLOCK"
          network_entity_key = "nat_gateway"
        },
        {
          destination        = "all-services"
          destination_type   = "SERVICE_CIDR_BLOCK"
          network_entity_key = "service_gateway"
        }
      ]
    }
  }

  security_lists = {
    app = {
      ingress_rules = [
        {
          description = "Allow VCN-internal SSH"
          protocol    = "6"
          source      = "10.30.0.0/16"
          tcp_options = {
            min = 22
            max = 22
          }
        }
      ]
      egress_rules = [
        {
          description = "Allow all outbound"
          protocol    = "all"
          destination = "0.0.0.0/0"
        }
      ]
    }
  }

  subnets = {
    app = {
      display_name                  = "fk-drg-app"
      cidr_block                    = "10.30.1.0/24"
      route_table_key               = "private"
      security_list_keys            = ["app"]
      include_default_security_list = false
      prohibit_internet_ingress     = true
      prohibit_public_ip_on_vnic    = true
    }
  }
}

module "drg" {
  source = "git::https://github.com/foggykitchen/terraform-oci-fk-drg.git"

  compartment_ocid = var.compartment_ocid
  name             = "fk-drg"

  vcn_attachments = {
    app = {
      vcn_id = module.vcn.vcn_id
    }
  }

  drg_route_tables = {
    vcn = {
      route_rules = [
        {
          destination             = "10.30.0.0/16"
          destination_type        = "CIDR_BLOCK"
          next_hop_attachment_key = "app"
        }
      ]
    }
  }
}
