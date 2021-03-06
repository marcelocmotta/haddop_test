#!/bin/bash
###
#  Parametros
###
ANO=2016
MESES=12
mkdir dados
mkdir dados/pids

#####
#  INstalando pre requisitos
#####
echo "Instalando pre requisitos"
#sudo apt-get install -y iotop
#sudo apt-get install -y unzip
#sudo apt-get install -y iftop

#####
#  Baixando arquivos do portal da transparência
#####
echo "Baixando arquivos\n"
CONT=1
while [ "$CONT" -le $MESES ]; do
  if [ "$CONT" -le 9 ]; then
    CONT_S=0$CONT
  else
    CONT_S=$CONT
  fi
  if [ "`ls dados | grep ${ANO}$CONT_S.zip`" == "" ]; then
    echo "\nBaixando ${ANO}${CONT_S}.zip"
    wget -q -O "dados/${ANO}$CONT_S.zip" "http://nozescloud.ddns.net:8008/${ANO}${CONT_S}_BolsaFamilia_Pagamentos.zip" &
    echo $! > dados/pids/$!
  else
    echo -e "\n${ANO}$CONT_S.zip já existe"
  fi
  CONT=$(($CONT + 1))
done
echo "Aguardando"
sleep 5
cd dados/pids
while [ true ]; do
  echo "Verificando processos ativos..."
  for x in *; do
    echo $x
    if [ "$(ps -aux | grep $x | wc -l)" == "1" ]; then
      rm $x
    fi
  done
  if [ "$(ls)" == "" ]; then
    break
  else
   echo "."
   sleep 5
  fi
done

while [ "$(ps -aux | grep wget | wc -l)" != "1" ]; do
  sleep 5
done

#####
#  Descompactando arquivos para CSV
#####
echo "Descompactando arquivos"
cd ../..
CONT=1
while [ "$CONT" -le $MESES ]; do
  if [ "$CONT" -le 9 ]; then
    CONT_S=0$CONT
  else
    CONT_S=$CONT
  fi
  if [ "`ls dados | grep ${ANO}${CONT_S}_BolsaFamiliaFolhaPagamento.csv`" == "" ]; then
    echo "\nDescompactando dados/${ANO}$CONT_S.zip"
    unzip -o "dados/${ANO}${CONT_S}.zip" -d dados &
    echo $! > dados/pids/$!
  else
    echo "${ANO}${CONT_S}_BolsaFamiliaFolhaPagamento.csv já existe"
  fi
  CONT=$(($CONT + 1))
done

echo "Aguardando"
cd dados/pids
while [ true ]; do
  echo "Verificando processos ativos..."
  for x in *; do
    echo $x
    if [ "$(ps -aux | grep $x | wc -l)" == "1" ]; then
      #echo "Removendo $x"
      rm $x
    #else
      #echo "N remover $x"
    fi
  done
  if [ "$(ls)" == "" ]; then
    break
  else
   echo "."
   sleep 5
  fi
done

echo "Processo de copia Finalizado"
