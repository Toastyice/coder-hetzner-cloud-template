data "coder_parameter" "region" {
  name         = "hcloud_region"
  display_name = var.display_name
  description  = var.description
  icon         = "https://cdn.hetzner.com/assets/Uploads/icon-circle-cloud.svg"
  mutable      = var.mutable
  default      = var.default != null && var.default != "" ? var.default : null
  order        = var.coder_parameter_order
  dynamic "option" {
    for_each = {
      for k, v in local.zones : k => v
      if anytrue([for d in var.regions : startswith(k, d)])
    }
    content {
      icon        = try(var.custom_icons[option.key], option.value.icon)
      name        = option.value.name
      description = option.key
      value       = option.key
    }
  }
}
