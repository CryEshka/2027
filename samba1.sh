sshpass -p 'P@ssw0rd' ssh -p 2027 -o StrictHostKeyChecking=no sshuser@192.168.0.2 "cat > /etc/net/ifaces/enp7s1/resolv.conf" << 'EOF'
search au-team.irpo
nameserver 192.168.100.2
EOF
