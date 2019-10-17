iptables -A INPUT -p tcp --dport 3240 -j DROP //запрещаем все по порту
//цикл считывания файла

iptables -I INPUT -p tcp -s 17.17.x.x --dport 3240 -j ACCEPT //разрешаем конкретному компу
