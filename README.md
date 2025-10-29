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