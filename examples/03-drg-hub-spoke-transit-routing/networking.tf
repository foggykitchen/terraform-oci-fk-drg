module "vcn_hub" {
  source = "git::https://github.com/mlinxfeld/terraform-oci-fk-vcn.git"

  compartment_ocid = var.compartment_ocid
  name             = "fk-vcn-hub"
  vcn_cidr_blocks  = ["10.0.0.0/16"]

  create_nat_gateway     = true
  create_service_gateway = true

  extra_network_entity_ids = {
    drg = module.drg_hub.drg_id
  }

  route_tables = {
    private = {
      display_name = "fk-hub-private"
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
        },
        {
          description        = "Spoke1 through DRG"
          destination        = "10.1.0.0/16"
          destination_type   = "CIDR_BLOCK"
          network_entity_key = "drg"
        },
        {
          description        = "Spoke2 through DRG"
          destination        = "10.2.0.0/16"
          destination_type   = "CIDR_BLOCK"
          network_entity_key = "drg"
        }
      ]
    }
  }

  security_lists = {
    app = {
      ingress_rules = [
        {
          description = "Allow hub-and-spoke internal SSH"
          protocol    = "6"
          source      = "10.0.0.0/8"
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
      display_name                  = "fk-hub-app"
      cidr_block                    = "10.0.1.0/24"
      route_table_key               = "private"
      security_list_keys            = ["app"]
      include_default_security_list = false
      prohibit_internet_ingress     = true
      prohibit_public_ip_on_vnic    = true
    }
  }
}

module "vcn_spoke1" {
  source = "git::https://github.com/mlinxfeld/terraform-oci-fk-vcn.git"

  compartment_ocid = var.compartment_ocid
  name             = "fk-vcn-spoke1"
  vcn_cidr_blocks  = ["10.1.0.0/16"]

  create_nat_gateway     = true
  create_service_gateway = true

  extra_network_entity_ids = {
    drg = module.drg_hub.drg_id
  }

  route_tables = {
    private = {
      display_name = "fk-spoke1-private"
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
        },
        {
          description        = "Hub through DRG"
          destination        = "10.0.0.0/16"
          destination_type   = "CIDR_BLOCK"
          network_entity_key = "drg"
        },
        {
          description        = "Spoke2 through DRG"
          destination        = "10.2.0.0/16"
          destination_type   = "CIDR_BLOCK"
          network_entity_key = "drg"
        }
      ]
    }
  }

  security_lists = {
    app = {
      ingress_rules = [
        {
          description = "Allow hub-and-spoke internal SSH"
          protocol    = "6"
          source      = "10.0.0.0/8"
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
      display_name                  = "fk-spoke1-app"
      cidr_block                    = "10.1.1.0/24"
      route_table_key               = "private"
      security_list_keys            = ["app"]
      include_default_security_list = false
      prohibit_internet_ingress     = true
      prohibit_public_ip_on_vnic    = true
    }
  }
}

module "vcn_spoke2" {
  source = "git::https://github.com/mlinxfeld/terraform-oci-fk-vcn.git"

  compartment_ocid = var.compartment_ocid
  name             = "fk-vcn-spoke2"
  vcn_cidr_blocks  = ["10.2.0.0/16"]

  create_nat_gateway     = true
  create_service_gateway = true

  extra_network_entity_ids = {
    drg = module.drg_hub.drg_id
  }

  route_tables = {
    private = {
      display_name = "fk-spoke2-private"
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
        },
        {
          description        = "Hub through DRG"
          destination        = "10.0.0.0/16"
          destination_type   = "CIDR_BLOCK"
          network_entity_key = "drg"
        },
        {
          description        = "Spoke1 through DRG"
          destination        = "10.1.0.0/16"
          destination_type   = "CIDR_BLOCK"
          network_entity_key = "drg"
        }
      ]
    }
  }

  security_lists = {
    app = {
      ingress_rules = [
        {
          description = "Allow hub-and-spoke internal SSH"
          protocol    = "6"
          source      = "10.0.0.0/8"
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
      display_name                  = "fk-spoke2-app"
      cidr_block                    = "10.2.1.0/24"
      route_table_key               = "private"
      security_list_keys            = ["app"]
      include_default_security_list = false
      prohibit_internet_ingress     = true
      prohibit_public_ip_on_vnic    = true
    }
  }
}

module "drg_hub" {
  source = "git::https://github.com/mlinxfeld/terraform-oci-fk-drg.git?ref=v0.3.0"

  compartment_ocid = var.compartment_ocid
  name             = "fk-drg-hub"

  vcn_attachments = {
    hub = {
      vcn_id              = module.vcn_hub.vcn_id
      drg_route_table_key = "from-hub"
    }
    spoke1 = {
      vcn_id              = module.vcn_spoke1.vcn_id
      drg_route_table_key = "from-spoke1"
    }
    spoke2 = {
      vcn_id              = module.vcn_spoke2.vcn_id
      drg_route_table_key = "from-spoke2"
    }
  }

  drg_route_tables = {
    from-hub = {
      display_name = "fk-drg-hub-from-hub"
      route_rules = [
        {
          destination             = "10.1.0.0/16"
          destination_type        = "CIDR_BLOCK"
          next_hop_attachment_key = "spoke1"
        },
        {
          destination             = "10.2.0.0/16"
          destination_type        = "CIDR_BLOCK"
          next_hop_attachment_key = "spoke2"
        }
      ]
    }
    from-spoke1 = {
      display_name = "fk-drg-hub-from-spoke1"
      route_rules = [
        {
          destination             = "10.0.0.0/16"
          destination_type        = "CIDR_BLOCK"
          next_hop_attachment_key = "hub"
        },
        {
          destination             = "10.2.0.0/16"
          destination_type        = "CIDR_BLOCK"
          next_hop_attachment_key = "spoke2"
        }
      ]
    }
    from-spoke2 = {
      display_name = "fk-drg-hub-from-spoke2"
      route_rules = [
        {
          destination             = "10.0.0.0/16"
          destination_type        = "CIDR_BLOCK"
          next_hop_attachment_key = "hub"
        },
        {
          destination             = "10.1.0.0/16"
          destination_type        = "CIDR_BLOCK"
          next_hop_attachment_key = "spoke1"
        }
      ]
    }
  }
}
