terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = "dop_v1_a54558b2ff03120f5d8cfa698b1f36954c663357e97cc46074af1c10565f9a30"
}

resource "digitalocean_droplet" "jenkins" {
  image    = "ubuntu-22-04-x64"
  name     = "jenkins"
  region   = "nyc1"
  size     = "s-2vcpu-2gb"
  ssh_keys = [data.digitalocean_ssh_key.Terraform.id]
}
data "digitalocean_ssh_key" "Terraform" {
  name = "Terraform"
}

resource "digitalocean_kubernetes_cluster" "foo" {
  name   = "foo"
  region = "nyc1"
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = "1.26.3-do.0"

  node_pool {
    name       = "default"
    size       = "s-2vcpu-2gb"
    node_count = 2
  }
}