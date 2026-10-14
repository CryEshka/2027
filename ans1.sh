echo "- Скачиваем файл инвентаря"
apt-get update && apt-get install -y ansible sshpass 
sed -i '/\[defaults\]/a host_key_checking = false' /etc/ansible/ansible.cfg
sed -i '/\[defaults\]/a interpreter_python = /usr/bin/python3' /etc/ansible/ansible.cfg
sed -i '/\[defaults\]/a inventory = /etc/ansible/inventory.yml' /etc/ansible/ansible.cfg
sei -i 
cd /etc/ansible
wget raw.githubusercontent.com/CryEshka/2027/main/get.yml
wget raw.githubusercontent.com/CryEshka/2027/main/inventory.yml
sshpass -p 'P@ssw0rd' ssh -p 2027 -o StrictHostKeyChecking=no sshuser@192.168.0.2 exit
sshpass -p 'P@ssw0rd' ssh -p 2027 -o StrictHostKeyChecking=no sshuser@192.168.100.1 exit
sshpass -p 'P@ssw0rd' ssh -p 2027 -o StrictHostKeyChecking=no sshuser@192.168.200.3 exit
sshpass -p 'P@ssw0rd' ssh -p 2027 -o StrictHostKeyChecking=no net_admin@192.168.100.1 exit
sshpass -p 'P@ssw0rd' ssh -p 2027 -o StrictHostKeyChecking=no net_admin@192.168.1.1 exit
ansible -m ping all
ansible-playbook /etc/ansible/get.yml
