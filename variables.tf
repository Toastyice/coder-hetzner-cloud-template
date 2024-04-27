variable "hcloud_token" {
  description = <<-EOF
  Coder requires a Hetzner Cloud token to provision workspaces.
  EOF
  sensitive   = true
  validation {
    condition     = length(var.hcloud_token) == 64
    error_message = "Please provide a valid Hetzner Cloud API token."
  }
}
