cd /etc/ansible
wget raw.githubusercontent.com/CryEshka/2027/main/get.yml
wget raw.githubusercontent.com/CryEshka/2027/main/inventory.yml
ansible -m ping all
ansible-playbook /etc/ansible/get.yml
