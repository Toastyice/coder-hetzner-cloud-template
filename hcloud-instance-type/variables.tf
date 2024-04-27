variable "token" {
  description = <<-EOF
  Coder requires a Hetzner Cloud token to provision workspaces.
  EOF
  sensitive   = true
  validation {
    condition     = length(var.token) == 64
    error_message = "Please provide a valid Hetzner Cloud API token."
  }
}

variable "display_name" {
  default     = "hcloud Instance type"
  description = "The display name of the parameter."
  type        = string
  validation {
    condition     = length(var.display_name) > 0
    error_message = "Display must not be empty"
  }
}

variable "description" {
  default     = "The region to deploy workspace infrastructure."
  description = "The description of the parameter."
  type        = string
}

variable "default" {
  default     = null
  description = "Default instance type"
  type        = string
}

variable "architecture" {
  description = "List of instance architectures to include."
  type        = set(string)
  default     = [
    "arm",
    "x86"
  ]
  validation {
    condition     = length(var.architecture) > 0
    error_message = "At least one architecture must be specified!"
  }
}

variable "cpu_type" {
  description = "List of cpu types to include."
  type        = set(string)
  default     = [
    "shared",
    "dedicated"
  ]
  validation {
    condition     = length(var.cpu_type) > 0
    error_message = "At least one cpu type must be specified!"
  }
}

variable "include_deprecated" {
  description = "Should deprecated instances be included?"
  type        = bool
  default     = false
}

variable "mutable" {
  default     = true
  description = "Whether the parameter can be changed after creation."
  type        = bool
}

variable "coder_parameter_order" {
  type        = number
  description = "The order determines the position of a template parameter in the UI/CLI presentation. The lowest order is shown first and parameters with equal order are sorted by name (ascending order)."
  default     = null
}
