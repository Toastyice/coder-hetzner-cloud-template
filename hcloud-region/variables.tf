variable "display_name" {
  default     = "hcloud Region"
  description = "The display name of the parameter."
  type        = string
}

variable "description" {
  default     = "The region to deploy workspace infrastructure."
  description = "The description of the parameter."
  type        = string
}

variable "default" {
  default     = "fsn1"
  description = "Default zone"
  type        = string
}

variable "regions" {
  description = "List of hcloud regions to include."
  type        = list(string)
  default     = [
    "fsn1",
    "nbg1",
    "hel1",
    "ash",
    "hil"
  ]
}

variable "mutable" {
  default     = false
  description = "Whether the parameter can be changed after creation."
  type        = bool
}

variable "custom_icons" {
  default     = {}
  description = "A map of custom icons for region IDs."
  type        = map(string)
}

variable "coder_parameter_order" {
  type        = number
  description = "The order determines the position of a template parameter in the UI/CLI presentation. The lowest order is shown first and parameters with equal order are sorted by name (ascending order)."
  default     = null
}
