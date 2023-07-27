#!/bin/bash

# Проверка количества аргументов
if [ "$#" -lt 4 ]; then
    echo "Использование: ./iptable_setup.sh <source_ip> <destination_ip> <port> <protocol1> <protocol2> ..."
    exit 1
fi

# Переменные
SOURCE_IP=$1
DEST_IP=$2
PORT=$3
shift 3

# Массив протоколов
PROTOCOLS=("$@")

# Цикл по протоколам
for PROTOCOL in "${PROTOCOLS[@]}"; do
    iptables -t nat -A PREROUTING -p $PROTOCOL -d $SOURCE_IP --dport $PORT -j DNAT --to-destination $DEST_IP:$PORT
    iptables -t nat -A POSTROUTING -p $PROTOCOL -m $PROTOCOL --dport $PORT -j SNAT --to-source $SOURCE_IP
done

echo "Правила iptables успешно установлены"
