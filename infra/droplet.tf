resource "digitalocean_droplet" "k8s_node" {
  image  = "debian-10-x64"
  name   = "k8s-node-${count.index}"
  region = var.region
  size   = "s-1vcpu-1gb"

  count = 3

  ssh_keys = [
    data.digitalocean_ssh_key.terraform_key.id
  ]

  backups            = false
  ipv6               = false
  private_networking = true

  vpc_uuid = digitalocean_vpc.k8s_the_hard_way.id

  connection {
    host        = self.ipv4_address
    user        = "root"
    type        = "ssh"
    private_key = file("~/.ssh/id_ecdsa")
    timeout     = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      "sleep 10",
      "export DEBIAN_FRONTEND=noninteractive",
      "apt-get update -y",
      "apt-get install -y nginx"
    ]

  }
}
