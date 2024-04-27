module "hcloud_region" {
  source  = "./hcloud-region"
  coder_parameter_order = 0
}

module "hcloud_instance_type" {
  source = "./hcloud-instance-type"
  token  = var.hcloud_token
  coder_parameter_order = 1
}

module "hcloud_os_type" {
  source = "./hcloud-os-type"
  token  = var.hcloud_token
  coder_parameter_order = 2
}

module "dotfiles" {
  source   = "registry.coder.com/modules/dotfiles/coder"
  version  = "1.0.13"
  agent_id = coder_agent.dev.id
  coder_parameter_order = 3
}

module "settings" {
  source     = "registry.coder.com/modules/code-server/coder"
  version    = "1.0.13"
  agent_id   = coder_agent.dev.id
  extensions = jsondecode(data.coder_parameter.code_server_extentions.value)
  #settings   = { #make configurable
  #  "workbench.colorTheme" = "Dracula"
  #}
  order = 4
}
