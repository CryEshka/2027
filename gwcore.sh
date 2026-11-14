# 1. Имя хоста и домен
hostnamectl set-hostname gw-core.ssa.prof; exec bash
hostname -f

# 2. Учётная запись и пароль
useradd -m 'master:P@ssw0rd'| chpasswd

# 3. Настройка sudo БЕЗ запроса пароля
apt-get install sudo
control sudo
control sudo help
usermod -aG wheel master
echo "master ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/master

# Получаем IP-адрес по DHCP на интерфейсе ens19 (внешняя сеть)
echo "TYPE=eth" > /etc/net/ifaces/ens19/options
echo "BOOTPROTO=dhcp" >> /etc/net/ifaces/ens19/options
systemctl restart network

# Создаём директории для внутренних интерфейсов и dummy0
mkdir -p /etc/net/ifaces/ens20 /etc/net/ifaces/ens21 
mkdir -p/etc/net/ifaces/ens22 /etc/net/ifaces/dummy0

# Создаём файл options для каждого интерфейса
echo "TYPE=eth" > /etc/net/ifaces/ens20/options
echo "TYPE=eth" > /etc/net/ifaces/ens21/options
echo "TYPE=eth" > /etc/net/ifaces/ens22/options
echo "TYPE=dummy" > /etc/net/ifaces/dummy0/options

# Назначаем IP-адреса в соответствии с L3-топологией
echo "84.212.78.1/27" > /etc/net/ifaces/ens20/ipv4address # К GW-1
echo "63.27.18.1/23" > /etc/net/ifaces/ens21/ipv4address # К GW-2
echo "34.95.33.1/24" > /etc/net/ifaces/ens22/ipv4address # К GW-3
echo "44.44.44.44/32" > /etc/net/ifaces/dummy0/ipv4address # Loopback

# 1. Включаем пересылку пакетов (forwarding)
sed -i "s/net.ipv4.ip_forward = 0/net.ipv4.ip_forward = 1/g" /etc/net/sysctl.conf
systemctl restart network
sysctl net.ipv4.ip_forward

# 2. Устанавливаем FRRouting
apt-get update && apt-get install -y frr

# 3. Включаем демоны bgpd и isisd
sed -i 's/bgpd=no/bgpd=yes/g' /etc/frr/daemons
sed -i 's/isisd=no/isisd=yes/g' /etc/frr/daemons

# 4. Включаем и добавляем в автозагрузку
systemctl enable --now frr
# 5. Проверяем запуск демонов
ss -tulpn | grep -E 'bgp|isis'
