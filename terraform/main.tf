terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
    }
    null = {
      source = "hashicorp/null"
    }
  }
}

provider "local" {}
provider "null" {}

variable "k3s_version" {
  default = "v1.31.1+k3s1"
}

variable "install_dir" {
  default = "/usr/local/bin"
}

resource "null_resource" "install_k3s" {
  provisioner "local-exec" {
    command = <<EOT
      # Install K3s as root
      curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=${var.k3s_version} sh -

      # Copy kubeconfig to user home
      mkdir -p $HOME/.kube
      sudo cp /etc/rancher/k3s/k3s.yaml $HOME/.kube/config
      sudo chown $USER:$USER $HOME/.kube/config
      chmod 600 $HOME/.kube/config
    EOT
  }

  triggers = {
    k3s_version = var.k3s_version
  }
}
