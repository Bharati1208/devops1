#!/bin/bash

cd terraform
terraform init
terraform apply -auto-approve

EC2_IP=$(terraform output -raw ec2_public_ip)

cd ../ansible
sed "s/\${EC2_IP}/$EC2_IP/g" inventory.ini > inventory_final.ini

ansible-playbook -i inventory_final.ini playbook.yml
