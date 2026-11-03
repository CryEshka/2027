mv docker.tkhis.pro.* /etc/nginx/ssl
mv web.tkhis.pro.* /etc/nginx/ssl

apt-get install -y openssl-gost-engine
control openssl-gost enabled
