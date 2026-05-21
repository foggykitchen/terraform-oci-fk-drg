module "vcn_home" {
  source = "git::https://github.com/mlinxfeld/terraform-oci-fk-vcn.git"

  compartment_ocid = var.compartment_ocid
  name             = "fk-drg-home-vcn"
  vcn_cidr_blocks  = ["10.30.0.0/16"]

  create_nat_gateway     = true
  create_service_gateway = true

  extra_network_entity_ids = {
    drg = module.drg_home.drg_id
  }

  route_tables = {
    private = {
      display_name = "fk-drg-home-private"
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
          description        = "Remote peer VCN through DRG"
          destination        = "10.40.0.0/16"
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
          description = "Allow VCN-internal SSH"
          protocol    = "6"
          source      = "10.30.0.0/16"
          tcp_options = {
            min = 22
            max = 22
          }
        },
        {
          description = "Allow remote VCN SSH"
          protocol    = "6"
          source      = "10.40.0.0/16"
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
      display_name                  = "fk-drg-home-app"
      cidr_block                    = "10.30.1.0/24"
      route_table_key               = "private"
      security_list_keys            = ["app"]
      include_default_security_list = false
      prohibit_internet_ingress     = true
      prohibit_public_ip_on_vnic    = true
    }
  }
}

module "drg_home" {
  source = "git::https://github.com/mlinxfeld/terraform-oci-fk-drg.git?ref=v0.4.0"

  compartment_ocid = var.compartment_ocid
  name             = "fk-drg-home"

  vcn_attachments = {
    app = {
      vcn_id              = module.vcn_home.vcn_id
      drg_route_table_key = "from-vcn"
    }
  }

  remote_peering_connections = {
    peer = {
      display_name = "fk-drg-home-rpc"
    }
  }

  drg_route_tables = {
    from-vcn = {
      display_name = "fk-drg-home-from-vcn"
      route_rules = [
        {
          destination                            = "10.40.0.0/16"
          destination_type                       = "CIDR_BLOCK"
          next_hop_rpc_attachment_management_key = "peer"
        }
      ]
    }
    from-rpc = {
      display_name = "fk-drg-home-from-rpc"
      route_rules = [
        {
          destination             = "10.30.0.0/16"
          destination_type        = "CIDR_BLOCK"
          next_hop_attachment_key = "app"
        }
      ]
    }
  }

  rpc_attachment_managements = {
    peer = {
      rpc_key             = "peer"
      drg_route_table_key = "from-rpc"
    }
  }
}

module "vcn_peer" {
  source = "git::https://github.com/mlinxfeld/terraform-oci-fk-vcn.git"

  providers = {
    oci = oci.peer
  }

  compartment_ocid = var.compartment_ocid
  name             = "fk-drg-peer-vcn"
  vcn_cidr_blocks  = ["10.40.0.0/16"]

  create_nat_gateway     = true
  create_service_gateway = true

  extra_network_entity_ids = {
    drg = module.drg_peer.drg_id
  }

  route_tables = {
    private = {
      display_name = "fk-drg-peer-private"
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
          description        = "Remote home VCN through DRG"
          destination        = "10.30.0.0/16"
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
          description = "Allow VCN-internal SSH"
          protocol    = "6"
          source      = "10.40.0.0/16"
          tcp_options = {
            min = 22
            max = 22
          }
        },
        {
          description = "Allow remote VCN SSH"
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
      display_name                  = "fk-drg-peer-app"
      cidr_block                    = "10.40.1.0/24"
      route_table_key               = "private"
      security_list_keys            = ["app"]
      include_default_security_list = false
      prohibit_internet_ingress     = true
      prohibit_public_ip_on_vnic    = true
    }
  }
}

module "drg_peer" {
  source = "git::https://github.com/mlinxfeld/terraform-oci-fk-drg.git?ref=v0.4.0"

  providers = {
    oci = oci.peer
  }

  compartment_ocid = var.compartment_ocid
  name             = "fk-drg-peer"

  vcn_attachments = {
    app = {
      vcn_id              = module.vcn_peer.vcn_id
      drg_route_table_key = "from-vcn"
    }
  }

  remote_peering_connections = {
    peer = {
      display_name     = "fk-drg-peer-rpc"
      peer_id          = module.drg_home.remote_peering_connection_ids["peer"]
      peer_region_name = var.home_region
    }
  }

  drg_route_tables = {
    from-vcn = {
      display_name = "fk-drg-peer-from-vcn"
      route_rules = [
        {
          destination                            = "10.30.0.0/16"
          destination_type                       = "CIDR_BLOCK"
          next_hop_rpc_attachment_management_key = "peer"
        }
      ]
    }
    from-rpc = {
      display_name = "fk-drg-peer-from-rpc"
      route_rules = [
        {
          destination             = "10.40.0.0/16"
          destination_type        = "CIDR_BLOCK"
          next_hop_attachment_key = "app"
        }
      ]
    }
  }

  rpc_attachment_managements = {
    peer = {
      rpc_key             = "peer"
      drg_route_table_key = "from-rpc"
    }
  }
}
