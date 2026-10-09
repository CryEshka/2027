sshpass -p 'P@ssw0rd' ssh -p 2027 -o StrictHostKeyChecking=no sshuser@192.168.0.2
cat > "/etc/net/ifaces/enp7s1/resolv.conf" <<EOF
search au-team.irpo
nameserver 192.168.100.2
EOF
exit
sshpass -p 'P@ssw0rd' ssh -p 2027 -o StrictHostKeyChecking=no sshuser@192.168.100.2
cat > "/etc/net/ifaces/enp7s1/resolv.conf" <<EOF
search au-team.irpo
nameserver 127.0.0.1
EOF
exit
sshpass -p 'P@ssw0rd' ssh -p 2027 -o StrictHostKeyChecking=no net_admin@192.168.100.1
cat > "/etc/net/ifaces/enp7s1/resolv.conf" <<EOF
search au-team.irpo
nameserver 192.168.100.2
EOF
exit
sshpass -p 'P@ssw0rd' ssh -p 2027 -o StrictHostKeyChecking=no net_admin@192.168.1.1
cat > "/etc/net/ifaces/enp7s1/resolv.conf" <<EOF
search au-team.irpo
nameserver 192.168.100.2
EOF
exit

