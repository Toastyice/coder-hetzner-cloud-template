output "value" {
  value = data.coder_parameter.instance_type.value
}

output "server_types" {
  value = data.hcloud_server_types.ds
}
