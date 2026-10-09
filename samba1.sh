sshpass -p 'P@ssw0rd' ssh -p 2027 -o StrictHostKeyChecking=no sshuser@192.168.0.2 << 'EOF'
echo -e "search au-team.irpo\nnameserver 192.168.100.2" | sudo tee /etc/net/ifaces/enp7s1/resolv.conf
EOF
