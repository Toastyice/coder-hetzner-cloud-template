terraform {
  required_version = ">= 1.0"
  required_providers {
    coder = {
      source  = "coder/coder"
      version = ">= 0.11"
    }
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = ">= 1.46"
    }
  }
}

provider "hcloud" {
  token = var.token
}
