1. Install k3sup
2. Install Kubernetes cluster using k3sup
   `k3sup install --local`
3. Install python3, python3-pip, python3-kubernetes
    `sudo snap install python3-pip`
4. Install ansible
5. Run `ansible-playbook deploy.yaml`