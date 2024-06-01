#!/bin/bash

yum install ansible -y
cd /tmp
git clone https://github.com/Rashid-Khan-Github/Ansible-Files.git
cd Ansible-Files/Ansible_Roles/roles

NAMES=("mongodb" "catalogue" "redis" "user" "cart" "mysql" "shipping" "rabbitmq" "payment" "web")

for i in "${NAMES[@]}"
do
    ansible-playbook -i inventory -e ansible_user=centos -e ansible_password=DevOps321 -e component=${i} main.yaml
done
