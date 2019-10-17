#!/bin/bash
#для пользователей создаем файл с конкретными фамилиями, 
#занимающими необходимое им устройство
ips=$(awk '{ print $1  }' /!script/tools/client_list.txt)
ipsa=("$ips")
fams=$(awk '{ print $2  }' /!script/tools/client_list.txt)
ip=$(netstat -an | grep :3240 | grep ESTABLISHED|awk '{print $5}'|cut -f1 -d":")
declare -a fam="( $fams )"
n=0
for i in $ipsa
do
if [[ "$i" == "$ip" ]];then
out=${fam[$n]}
fi
n=$((n+1))
done
if [[ -z "$out" ]]; then
out=$ip
fi
echo $out
echo $out > /ram_drive/usbip_fam.txt