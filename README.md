# Prerequisites
1. Create directories for media and config and place them in the `media_storage_path` and `config_storage_path` variables in the `./ansible/playbooks/deploy.yaml` file.

# Create cluster

1. Install Terraform, Ansible
2. Create cluster
   Run
   ```
   cd ./terraform
   terraform apply
   ```
3. Destroy cluster
   Run
   `terraform destroy`
4. Deploy apps
   Run
   ```
   cd ./ansible
   ansible-playbook playbooks/deploy.yaml
   ```
5. Undeploy apps
   Run
   `ansible-playbook playbooks/undeploy.yaml`

# Defaults
Every app has default user `htpcuser` and default password `htpcpass`.