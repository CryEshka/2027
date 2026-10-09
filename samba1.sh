sshpass -p P@ss0rd ssh-o StictHostKeyChecking=no root@172.16.1.1 
cat > "/etc/net/ifaces/enp7s1/resolv.conf" <<EOF
search au-team.irpo
nameserver 127.0.0.1
EOF
