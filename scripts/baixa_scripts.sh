#!/bin/bash
###
apt-get install wget -y
mkdir /tmp/scripts
cd /tmp/scripts
wget https://raw.githubusercontent.com/marcelocmotta/haddop_test/master/scripts/instala_node_exporter.sh
wget https://raw.githubusercontent.com/marcelocmotta/haddop_test/master/scripts/instala_prometheus.sh
wget https://raw.githubusercontent.com/marcelocmotta/haddop_test/master/scripts/baixar_dados.sh
wget https://raw.githubusercontent.com/leonardoreboucas/comparativo-aws-gcloud/master/copiar_para_hadoop.sh
wget https://raw.githubusercontent.com/leonardoreboucas/comparativo-aws-gcloud/master/monitoramento.sh
wget https://raw.githubusercontent.com/leonardoreboucas/comparativo-aws-gcloud/master/workload1.sh
wget https://raw.githubusercontent.com/leonardoreboucas/comparativo-aws-gcloud/master/workload2.sh
