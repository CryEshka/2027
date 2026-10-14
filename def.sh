Bash
sed -i "/\[defaults\]/a inventory = /etc/ansible/
inventory yml\ninterpreter_python = /
usr/bin/python3\nhost_key_checking = false" /etc/ansible/ansible.cfg
