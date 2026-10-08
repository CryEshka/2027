apt-get install -y nginx apache2-htpasswd

htpasswd -bc /etc/nginx/.htpasswd WEB 'P@ssw0rd'

printf '%s\n' \
'server {' \
$'\#tlisten 443 ssl;' \
$'\tlisten 80;' \
$'\tserver_name web.au-team.irpo;' \
$'\#ssl_certificate /etc/nginx/ssl/web.au-team.irpo.cer;' \
$'\#ssl_certificate_key /etc/nginx/ssl/web.au-team.irpo.key;' \
$'\#ssl_ciphers GOST2012-GOST8912-GOST8912:HIGH:MEDIUM;' \
$'\#ssl_protocols TLSv1 TLSv1.1 TLSv1.2;' \
$'\#ssl_prefer_server_ciphers on;' \
'' \
$'\tlocation / {' \
$'\t\tproxy_pass http://172.16.1.2:8080;' \
$'\t\tproxy_set_header Host $host;' \
$'\t\tproxy_set_header X-Real-IP $remote_addr;' \
$'\t\tproxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;' \
$'\t\tproxy_set_header X-Forwarded-Proto $scheme;' \
$'\t\tauth_basic "Restricted area";' \
$'\t\tauth_basic_user_file /etc/nginx/.htpasswd;' \
$'\t}' \
'}' \
'' \
'server {' \
$'\tlisten 80;' \
$'\#tlisten 443 ssl;' \
$'\tserver_name docker.au-team.irpo;' \
$'\#ssl_certificate /etc/nginx/ssl/docker.au-team.irpo.cer;' \
$'\#ssl_certificate_key /etc/nginx/ssl/docker.au-team.irpo.key;' \
$'\#ssl_ciphers GOST2012-GOST8912-GOST8912:HIGH:MEDIUM;' \
$'\#ssl_protocols TLSv1 TLSv1.1 TLSv1.2;' \
$'\#ssl_prefer_server_ciphers on;' \
'' \
$'\tlocation / {' \
$'\t\tproxy_pass http://172.16.2.2:8080;' \
$'\t\tproxy_set_header Host $host;' \
$'\t\tproxy_set_header X-Real-IP $remote_addr;' \
$'\t\tproxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;' \
$'\t\tproxy_set_header X-Forwarded-Proto $scheme;' \
$'\t}' \
'}' \
> /etc/nginx/sites-available.d/default.conf

ln -s /etc/nginx/sites-available.d/default.conf /etc/nginx/sites-enabled.d/

nginx -t

systemctl enable --now nginx

systemctl restart nginx
