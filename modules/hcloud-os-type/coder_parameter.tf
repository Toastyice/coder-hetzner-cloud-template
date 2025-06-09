data "coder_parameter" "os" {
  name         = "hcloud_os"
  display_name = var.display_name
  description  = var.description
  icon         = "https://cdn.hetzner.com/assets/Uploads/icon-circle-cloud.svg"
  mutable      = var.mutable
  default      = var.default != null && var.default != "" ? var.default : null
  order        = var.coder_parameter_order
  dynamic "option" {
    for_each = local.os_list
    content {
      name  = replace(option.value, "-", " ")
      value = option.value
      # the icon for rocky and alma needs to have a linux appended
      icon = (
        "/icon/${split("-", option.value)[0] == "alma" || split("-", option.value)[0] == "rocky" ?
        "${split("-", option.value)[0]}linux" : split("-", option.value)[0]}.svg"
      )
    }
  }
}
