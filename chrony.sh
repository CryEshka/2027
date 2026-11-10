apt-get update && apt-get install chrony.service
sed -i 's/pool pool.ntp.org iburst/server 127.0.0.1 iburst prefer minstratum 4/g'
echo 'allow all' /etc/chony.conf
echo 'local stratum 5'>> /etc/chony.conf
