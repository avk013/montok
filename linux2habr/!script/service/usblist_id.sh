#создаем лист идентификаторов юсб устройств
usbip list -r 127.0.0.1 | grep ':' |awk -F ":" '{print $1}'| sed s/' '//g | grep -v "^$" > /ram_drive/usb_id.txt

