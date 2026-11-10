# ==============================================================================
# HCP Terraform Search / Query — Découverte de ressources IBM Cloud
# Fichier : ibm_discovery.tfquery.hcl
#
# Ressources recherchées :
#   - Instances VSI (Virtual Server Instance) : ibm_is_instance
#   - Groupes de Sécurité (Security Groups)   : ibm_is_security_group
#
# Commandes :
#   1. Découverte : terraform query
#   2. Génération : terraform plan -generate-config-out=ibm_generated.tf
#   3. Import     : terraform apply
# ==============================================================================

# ------------------------------------------------------------------------------
# 1. Instances VSI (ibm_is_instance) par région
# ------------------------------------------------------------------------------

# --- Europe ---
list "ibm_is_instance" "vsi_eu_de" {
  provider = ibm
  config {
    region = "eu-de" # Francfort
  }
}

list "ibm_is_instance" "vsi_eu_gb" {
  provider = ibm
  config {
    region = "eu-gb" # Londres
  }
}

list "ibm_is_instance" "vsi_mad" {
  provider = ibm
  config {
    region = "mad" # Madrid
  }
}

# --- Amérique du Nord ---
list "ibm_is_instance" "vsi_us_south" {
  provider = ibm
  config {
    region = "us-south" # Dallas
  }
}

list "ibm_is_instance" "vsi_us_east" {
  provider = ibm
  config {
    region = "us-east" # Washington DC
  }
}

list "ibm_is_instance" "vsi_ca_tor" {
  provider = ibm
  config {
    region = "ca-tor" # Toronto
  }
}

# --- Asie-Pacifique ---
list "ibm_is_instance" "vsi_jp_tok" {
  provider = ibm
  config {
    region = "jp-tok" # Tokyo
  }
}

list "ibm_is_instance" "vsi_au_syd" {
  provider = ibm
  config {
    region = "au-syd" # Sydney
  }
}

# ------------------------------------------------------------------------------
# 2. Security Groups (ibm_is_security_group) par région
# ------------------------------------------------------------------------------

# --- Europe ---
list "ibm_is_security_group" "sg_eu_de" {
  provider = ibm
  config {
    region = "eu-de"
  }
}

list "ibm_is_security_group" "sg_eu_gb" {
  provider = ibm
  config {
    region = "eu-gb"
  }
}

list "ibm_is_security_group" "sg_mad" {
  provider = ibm
  config {
    region = "mad"
  }
}

# --- Amérique du Nord ---
list "ibm_is_security_group" "sg_us_south" {
  provider = ibm
  config {
    region = "us-south"
  }
}

list "ibm_is_security_group" "sg_us_east" {
  provider = ibm
  config {
    region = "us-east"
  }
}

list "ibm_is_security_group" "sg_ca_tor" {
  provider = ibm
  config {
    region = "ca-tor"
  }
}
