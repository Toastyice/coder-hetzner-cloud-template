terraform {
  required_providers {
    coder = {
      source  = "coder/coder"
      version = "2.5.3"
    }
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.51.0"
    }
  }
}

provider "hcloud" {
  token = var.hcloud_token
}

provider "coder" {
}
