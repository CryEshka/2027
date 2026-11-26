#!/bin/bash
hostnamectl set-hostname cod-sw-core.cod.ssa.prof; exec bash
hostname -f
apt-get update
useradd master
passwd master
control sudo
control sudo help
usermod -aG wheel master
echo "master ALL=(ALL:ALL) PASSWD: ALL" > /etc/sudoers.d/master

ip link add link ens18 name ens18.10 type vlan id 10
ip link set dev ens18.10 up
ip addr add 192.168.10.2/24 dev ens18.10
ip route add 0.0.0.0/0 via 192.168.10.1
echo "nameserver 77.88.8.8" > /etc/resolv.conf
ping -c3 ya.ru

apt-get update && apt-get install -y openvswitch
sed -i "s/OVS_REMOVE=yes/OVS_REMOVE=no/g" /etc/net/ifaces/default/options
systemctl enable --now openvswitch.service
reboot

echo "TYPE=eth" > /etc/net/ifaces/ens18/options
cp -r /etc/net/ifaces/ens18/ /etc/net/ifaces/ens19
cp -r /etc/net/ifaces/ens18/ /etc/net/ifaces/ens20
cp -r /etc/net/ifaces/ens18/ /etc/net/ifaces/ens21
cp -r /etc/net/ifaces/ens18/ /etc/net/ifaces/ens22
cp -r /etc/net/ifaces/ens18/ /etc/net/ifaces/ens23
mkdir /etc/net/ifaces/COD-SW-CORE
cat <<EOF > /etc/net/ifaces/COD-SW-CORE/options
TYPE=ovsbr
HOST='ens18 ens19 ens20 ens21 ens22 ens23'
EOF
mkdir /etc/net/ifaces/MGMT
cat <<EOF > /etc/net/ifaces/MGMT/options
TYPE=ovsport
BRIDGE=COD-SW-CORE
VID=10
EOF
echo '192.168.10.2/24' > /etc/net/ifaces/MGMT/ipv4address
echo 'default via 192.168.10.1' > /etc/net/ifaces/MGMT/ipv4route
echo 'nameserver 192.168.10.5' > /etc/net/ifaces/MGMT/resolv.conf
systemctl restart network

ovs-vsctl set Port ens18 trunks=10,20,30
ovs-vsctl set Port ens19 tag=10
ovs-vsctl set Port ens20 tag=20
ovs-vsctl set Port ens21 tag=10
ovs-vsctl set Port ens22 tag=30
ovs-vsctl set Port ens23 tag=10
ovs-vsctl show
ping -c3 77.88.8.8
passwd master
control sudo
control sudo help
usermod -aG wheel master
echo "master ALL=(ALL:ALL) PASSWD: ALL" > /etc/sudoers.d/master
