#!/bin/bash
###
#  Parametros
###
PACOTE=node_exporter-0.17.0.linux-amd64

#####
#  download
#####
apt-get update
apt-get install systemd wget tar -y
useradd --no-create-home --shell /bin/false node_exporter

echo "baixando source node_exporter"
wget https://github.com/prometheus/node_exporter/releases/download/v0.17.0/${PACOTE}.tar.gz
#####
#  Descompactando
#####
echo "descompactando node_exporter"
tar -xvzf "$PACOTE".tar.gz
mv "$PACOTE"/node_exporter /usr/local/bin/
chown node_exporter:node_exporter /usr/local/bin/node_exporter
#####
#  servico
#####
echo "configurando servico node_exporter"
echo "[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target" >>  /etc/systemd/system/node_exporter.service
systemctl daemon-reload
systemctl start node_exporter
systemctl enable node_exporter
echo "instalacao node_exporter finalizada"
