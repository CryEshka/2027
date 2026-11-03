apt-get update && apt-get install -y openssl-gost-engine

control openssl-gost enabled

openssl req -new -x509 -md_gost12_256 -days 30 -newkey gost2012_256 -pkeyopt paramset:A -keyout ca.key -out ca.cer -nodes -subj "/C=RU/O=tkhis.pro/CN=hq-srv.tkhis.pro"

openssl req -new -md_gost12_256 -newkey gost2012_256 -pkeyopt paramset:A -nodes -keyout web.tkhis.pro.key -out web.tkhis.pro.csr -subj "/C=RU/O=tkhis.pro/CN=web.tkhis.pro"

openssl x509 -req -md_gost12_256 -days 30 -in web.tkhis.pro.csr -CA ca.cer -CAkey ca.key -CAcreateserial -out web.tkhis.pro.cer

openssl req -new -md_gost12_256 -newkey gost2012_256 -pkeyopt paramset:A -nodes -keyout docker.tkhis.pro.key -out docker.tkhis.pro.csr -subj "/C=RU/O=tkhis.pro/CN=docker.tkhis.pro"

openssl x509 -req -md_gost12_256 -days 30 -in docker.tkhis.pro.csr -CA ca.cer -CAkey ca.key -CAcreateserial -out docker.tkhis.pro.cer

scp web.tkhis.pro.key root@172.16.1.1:~/
scp web.tkhis.pro.cer root@172.16.1.1:~/
scp docker.tkhis.pro.key root@172.16.1.1:~/
scp docker.tkhis.pro.cer root@172.16.1.1:~/
