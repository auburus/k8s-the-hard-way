resource "digitalocean_firewall" "k8s_the_hard_way" {
  name        = "k8s-the-hard-way"
  droplet_ids = digitalocean_droplet.k8s_node.*.id

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # TODO: Limit this to the LoadBalancer once it is configured
  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "icmp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # Allow all traffic within the cluster
  inbound_rule {
    protocol           = "tcp"
    port_range         = "1-65535"
    source_droplet_ids = digitalocean_droplet.k8s_node.*.id
  }
  inbound_rule {
    protocol           = "udp"
    port_range         = "1-65535"
    source_droplet_ids = digitalocean_droplet.k8s_node.*.id
  }
  inbound_rule {
    protocol           = "icmp"
    source_droplet_ids = digitalocean_droplet.k8s_node.*.id
  }

  outbound_rule {
    protocol                = "tcp"
    port_range              = "1-65535"
    destination_droplet_ids = digitalocean_droplet.k8s_node.*.id
  }
  outbound_rule {
    protocol                = "udp"
    port_range              = "1-65535"
    destination_droplet_ids = digitalocean_droplet.k8s_node.*.id
  }
  outbound_rule {
    protocol                = "icmp"
    destination_droplet_ids = digitalocean_droplet.k8s_node.*.id
  }
}
