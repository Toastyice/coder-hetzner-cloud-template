data "coder_parameter" "instance_type" {
  name         = "hcloud_instance_type"
  display_name = var.display_name
  description  = var.description
  icon         = "https://cdn.hetzner.com/assets/Uploads/icon-circle-cloud.svg"
  mutable      = var.mutable
  default      = var.default != null && var.default != "" ? var.default : null
  order        = var.coder_parameter_order
  dynamic "option" {
    for_each = {
      for k, v in data.hcloud_server_types.ds.server_types : k => v
      if contains(var.architecture, v.architecture) &&
      contains(var.cpu_type, v.cpu_type) &&
      var.include_deprecated ? true : !v.is_deprecated
    }
    content {
      name        = option.value.description
      description = <<-EOF
      arch ${option.value.architecture} 
      cpu_type ${option.value.cpu_type} 
      cores ${option.value.cores} 
      ram ${option.value.memory}GB 
      disk ${option.value.disk}GB
      EOF
      value       = option.value.name
    }
  }
}
