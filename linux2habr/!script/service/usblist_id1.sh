#отладка ручками
#usbip list -r 127.0.0.1 | grep ':' |awk -F ":" '{print $1}'| sed s/' '//g | grep -v "^$"

usbip list -r 127.0.0.1 
#| grep ':' 
#|awk -F ":" '{print $1}'| sed s/' '//g | grep -v "^$"


