#!/bin/bash
yum update -y
yum install -y squid

cat <<EOF > /etc/squid/squid.conf
${squid_config}
EOF

systemctl enable squid
systemctl start squid