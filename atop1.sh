#!/bin/bash
apt-get install atop -y
systemctl enable --now atop
cat <<EOF > /etc/default/atop
LOGOPTS="-R"
LOGINTERVAL=120
LOGGENERATIONS=28
LOGPATH=/var/log/atop
EOF
