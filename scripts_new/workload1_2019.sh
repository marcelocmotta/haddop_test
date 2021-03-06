#!/bin/bash
###
#  Parametros
###
ANO=2019
MESES=11
HADOOP_JAR=/usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar
WORKLOAD=workload12019

echo "------------------------ Inicio ----------------------------"
rm -rf $WORKLOAD

###
#  Iniciando o monitoramento
###
#./monitoramento.sh start $WORKLOAD

###
#  Execução do Wokload
###
echo "Executando WORKLOAD 1 - Contando a qtde de bolsas familia pagas em 2017 por estado"
hadoop jar $HADOOP_JAR grep /input/${ANO}*.csv /output/$WORKLOAD "^[A-Z][A-Z]\t"
echo "${WORKLOAD} finalizado"

###
#  Imprimindo o resultado
###
echo "Imprimindo resultado"
hdfs dfs -cat /output/$WORKLOAD/part-r-00000 > $WORKLOAD/resultado.txt
cat $WORKLOAD/resultado.txt

###
#  Finalizando o monitoramento
###
#./monitoramento.sh stop $WORKLOAD

echo "-------------------------------Fim-----------------------------"
