#!/bin/bash
###
#  Parametros
###
IPSLAVE2=20.20.20.20
IPSLAVE1=10.10.10.10
###
#  instalando docker
###
echo "instalando o docker"
apt-get update
apt-get install docker -y
###
#  criando prometheus.yml
###
echo "global:
        scrape_interval: 10s
      scrape_configs:
       - job_name: 'prometheus_master'
         scrape_interval: 1s
         static_configs:
           - targets: ['localhost:9090']

      - job_name: 'node_exporter_1'
        scrape_interval: 1s
        static_configs:
          - targets: ['${IPSLAVE1}:9100']

      - job_name: 'node_exporter_2'
        scrape_interval: 1s
        static_configs:
          - targets: ['${IPSLAVE2}:9100']" >> /tmp/prometheus.yml
###
#  subindo imagem prometheus
###
echo "subindo imagem prometheus"
docker run -d -p 9090:9090 -v /tmp/prometheus.yml:/etc/prometheus/prometheus.yml -e --storage.tsdb.path=data/ -e --web.enable-admin-api prom/prometheus
echo "instalacao prometheus finalizada"
