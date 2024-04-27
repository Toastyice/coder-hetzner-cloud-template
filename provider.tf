terraform {
  required_providers {
    coder = {
      source  = "coder/coder"
      version = "0.21.0"
    }
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.46.1"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}

provider "coder" {
}
