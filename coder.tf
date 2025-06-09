data "coder_parameter" "volume_size" {
  name        = "volume_size"
  description = "Disk Size in GB"
  default     = 10
  type        = "number"
  mutable     = true
  validation {
    min       = 10
    max       = 250
    monotonic = "increasing"
  }
}

data "coder_parameter" "code_server_extentions" {
  name        = "code-server extentions"
  type        = "list(string)"
  description = "List of code-server extentions"
  mutable     = true
  default = jsonencode([
    "dracula-theme.theme-dracula",
    "ms-toolsai.jupyter",
    "redhat.vscode-yaml",
    "redhat.vscode-xml",
    "redhat.ansible",
    "samuelcolvin.jinjahtml",
    "PKief.material-icon-theme",
    "hashicorp.terraform",
    "hashicorp.hcl",
    "GitLab.gitlab-workflow",
    "scala-lang.scala",
    "scalameta.metals"
  ])
}

data "coder_workspace" "me" {
}

data "coder_workspace_owner" "me" {
}

resource "coder_agent" "dev" {
  arch = strcontains(module.hcloud_instance_type.value, "cax") ? "arm64" : "amd64" #change this!
  os   = "linux"

  metadata {
    display_name = "CPU Usage"
    key          = "cpu"
    script       = <<EOT
    echo "$[100-$(vmstat 1 2|tail -1|awk '{print $15}')]"%
    EOT
    interval     = 15
    timeout      = 5
  }

  metadata {
    display_name = "Memory Usage"
    key          = "RAM"
    script       = <<EOT
    free | awk '/^Mem/ { printf("%.0f%%", $2/$4 ) }'
    EOT
    interval     = 15
    timeout      = 1
  }

  metadata {
    display_name = "Load Average"
    key          = "load"
    script       = <<EOT
    awk '{print $1}' /proc/loadavg
    EOT
    interval     = 15
    timeout      = 1
  }

  metadata {
    display_name = "Disk Usage /"
    key          = "disk-root"
    script       = <<EOT
    df -h / | awk '{ print $5 }' | tail -1
    EOT
    interval     = 15
    timeout      = 1
  }

  metadata {
    display_name = "Disk Usage home"
    key          = "disk-home"
    script       = <<EOT
    df -h /home/* | awk '{ print $5 }' | tail -1
    EOT
    interval     = 15
    timeout      = 1
  }

  metadata {
    display_name = "Process Count"
    key          = "process_count"
    script       = <<EOT
    ps aux | wc -l
    EOT
    interval     = 10
    timeout      = 1
  }

  metadata {
    display_name = "Container Count"
    key          = "container_count"
    script       = <<EOT
    [ -x "$(command -v docker)" ] && sudo docker ps | tail -n +2 | wc -l && exit 0
    [ -x "$(command -v podman)" ] && podman ps      | tail -n +2 | wc -l && exit 0
    echo 0
    EOT
    interval     = 15
    timeout      = 1
  }
}
