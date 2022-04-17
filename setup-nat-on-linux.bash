#!/usr/bin/env bash

set -euo pipefail

SRC_IP_CIDR=192.168.1.0/24

grep -qsE '^\s*net.ipv4.ip_forward\s*=\s*1' || \
  { 
    sudo echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
    sudo sysctl -p
  }
  
[[ -e /etc/systemd/system/nat.service ]] && { echo "nat.service already exists" 1>&2 ; exit 1 ; }
  
sudo tee /etc/systemd/system/nat.service &>/dev/null <<EOF
[Unit]
Description=Setup NAT
Requires=network.target
After=network.target

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/sbin/iptables -t nat -A POSTROUTING -s "$SRC_IP_CIDR" -j MASQUERADE
ExecStop=/sbin/iptables -t nat -A POSTROUTING -s "$SRC_IP_CIDR" -j MASQUERADE

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl enable --now nat.service

