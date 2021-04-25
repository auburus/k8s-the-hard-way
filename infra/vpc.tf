resource "digitalocean_vpc" "k8s_the_hard_way" {
  name     = "k8s-the-hard-way"
  region   = var.region
  ip_range = "192.168.5.0/24"
}
