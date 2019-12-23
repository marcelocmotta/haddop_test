#!/bin/bash
###
#  Parametros
###
PACOTE=prometheus-2.2.1.linux-amd64
IP1=10.10.10.10
IP2=20.20.20.20
IP3=30.30.30.30
#####
#  download
#####
apt-get update
apt-get install systemd wget tar -y
useradd -m -s /bin/bash prometheus

echo "baixando source prometheus"
wget https://github.com/prometheus/prometheus/releases/download/v2.2.1/${PACOTE}.tar.gz
#####
#  Descompactando
#####
echo "descompactando prometheus"
tar -xvzf "$PACOTE".tar.gz
mv "$PACOTE"/ /home/prometheus/prometheus/
chown prometheus:prometheus /home/prometheus/prometheus
#####
#  servico
#####
echo "configurando servico prometheus"
echo "global:
  scrape_interval: 10s
scrape_configs:
  - job_name: 'prometheus_master'
    scrape_interval: 1s
    static_configs:
      - targets: ['localhost:9090']

  - job_name: 'node_exporter_Externo'
    scrape_interval: 1s
    static_configs:
      - targets: ['localhost:9100']
          
  - job_name: 'node_exporter_Externos'
    scrape_interval: 1s
    static_configs:
      - targets: ['${IP1}:9100','${IP2}:9100','${IP3}:9100']" >> /tmp/prometheus.yml
echo "[Unit]
Description=Prometheus Server
Documentation=https://prometheus.io/docs/introduction/overview/
After=network-online.target

[Service]
User=prometheus
Restart=on-failure

#Change this line if you download the
#Prometheus on different path user
ExecStart=/home/prometheus/prometheus/prometheus \
  --config.file=/tmp/prometheus.yml \
  --storage.tsdb.path=/home/prometheus/prometheus/data \
  --web.enable-admin-api

[Install]
WantedBy=multi-user.target" >>  /etc/systemd/system/prometheus.service
chmod 644 /etc/systemd/system/prometheus.service
systemctl daemon-reload
systemctl start prometheus
systemctl enable prometheus
echo "instalacao prometheus finalizada"
