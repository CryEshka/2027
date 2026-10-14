sed -i '/\[defaults\]/a host_key_checking = false' /etc/ansible/ansible.cfg
sed -i '/\[defaults\]/a interpreter_python = /usr/bin/python3' /etc/ansible/ansible.cfg
sed -i '/\[defaults\]/a inventory = /etc/ansible/inventory.yml' /etc/ansible/ansible.cfg
