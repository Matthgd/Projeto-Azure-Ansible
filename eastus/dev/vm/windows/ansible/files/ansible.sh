#! /bin/bash

echo "Running ansible playbook"
echo "Generating inventory file with terraform outputs"
INVENTORY_FILE_NAME="hosts.ini"
HOST=$(terraform output -raw private_ip_addresses)

echo ${HOST} >> ${INVENTORY_FILE_NAME}
echo " " >> ${INVENTORY_FILE_NAME}
echo "[all:vars]" >> ${INVENTORY_FILE_NAME}
echo "ansible_user=$1" >> ${INVENTORY_FILE_NAME}
echo "ansible_password=$2" >> ${INVENTORY_FILE_NAME}
echo "ansible_pat=$3" >> ${INVENTORY_FILE_NAME}
echo "ansible_connection=winrm" >> ${INVENTORY_FILE_NAME}
echo "ansible_winrm_transport=ntlm" >> ${INVENTORY_FILE_NAME}
echo "ansible_winrm_server_cert_validation=ignore" >> ${INVENTORY_FILE_NAME}


echo "[Running Ansible Playbook - Configure Windows VM]"
echo "Configuring Host: $HOST"

# Running the playbook
ansible-playbook ../../../ansible/configure_windows.yaml -i ${INVENTORY_FILE_NAME} -v
