
output "ip_address" {
  value = digitalocean_droplet.k8s_node.*.ipv4_address
}