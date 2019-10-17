#!/bin/bash
sudo iptables -A INPUT -p tcp --dport 3240 -j DROP
#echo `awk '{ print $1  }' ../client_list.txt`
datas=""
exec 5>&1
datas=$(awk '{ print $1  }' ../client_list.txt)
#echo $datas
arr="$datas"
echo "===="
#echo $a[1]
for x in $arr
do
#echo $x
echo "iptables -I INPUT -p tcp -s $x --dport 3240 -j ACCEPT"
sudo iptables -I INPUT -p tcp -s $x --dport 3240 -j ACCEPT

done

