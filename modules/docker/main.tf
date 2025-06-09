terraform {
  required_version = ">= 1.0"
  required_providers {
    coder = {
      source  = "coder/coder"
      version = ">= 0.12"
    }
  }
}

variable "agent_id" {
  type        = string
  description = "The ID of a Coder agent."
}

resource "coder_script" "docker" {
  agent_id     = var.agent_id
  display_name = "Docker"
  script = templatefile("${path.module}/run.sh", {
  })
  icon               = "/icon/docker.svg"
  run_on_start       = true
  start_blocks_login = true
}
