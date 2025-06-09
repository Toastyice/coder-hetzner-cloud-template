data "hcloud_images" "images" {
  include_deprecated = var.include_deprecated
}

locals {
  os_list = sort(distinct([
    for item in data.hcloud_images.images.images : item.name if
    contains(var.os_flavor, item.os_flavor) &&
    item.type == "system" #make configurable
  ]))
}
