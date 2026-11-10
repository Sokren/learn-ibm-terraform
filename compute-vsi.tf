data "ibm_is_image" "image" {
  name = var.image_name
}

resource "tls_private_key" "rsa_4096_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  content         = tls_private_key.rsa_4096_key.private_key_pem
  filename        = "rsakey.pem"
  file_permission = "0600"
}

# Generate an SSH Key
resource "ibm_is_ssh_key" "generated_ssh_key" {
  name           = "${local.basename}-ssh-key"
  resource_group = local.resource_group_id
  public_key     = tls_private_key.rsa_4096_key.public_key_openssh
}

# Create a VSI (Virtual Server Instance)
resource "ibm_is_instance" "vsi" {
  name           = "${local.basename}-vsi"
  vpc            = ibm_is_vpc.vpc.id
  zone           = ibm_is_subnet.subnet.zone
  profile        = var.profile_name
  image          = data.ibm_is_image.image.id
  keys           = [ibm_is_ssh_key.generated_ssh_key.id]
  resource_group = local.resource_group_id
  tags           = var.tags

  primary_network_attachment {
    name = "vni-primary-att"
    virtual_network_interface {
      id = ibm_is_virtual_network_interface.vni.id
    }
  }

  boot_volume {
    name = "${local.basename}-boot"
  }
}

resource "ibm_is_virtual_network_interface" "vni" {
  name              = "${local.basename}-vni"
  allow_ip_spoofing = false
  auto_delete       = false
  # When VNI targeted for VSI, enable_infrastructure_nat cannot be set to false
  enable_infrastructure_nat = true
  primary_ip {
    auto_delete = false
    address     = "10.10.10.8"
  }
  resource_group = local.resource_group_id
  subnet         = ibm_is_subnet.subnet.id
}

# A Public Floating IP for the VSI
resource "ibm_is_floating_ip" "public_ip" {
  name           = "${local.basename}-floating-ip"
  target         = ibm_is_instance.vsi.primary_network_attachment[0].virtual_network_interface[0].id
  resource_group = local.resource_group_id
  tags           = var.tags
}
