output "value" {
  value = data.coder_parameter.os.value
}

output "hcloud_images_all" {
  value = data.hcloud_images.images
}

output "hcloud_images_filtered" {
  value = local.os_list
}
