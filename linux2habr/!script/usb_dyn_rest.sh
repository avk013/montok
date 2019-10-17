#рестарт и расшаривание всех устройств, 
#возможно требуется дополнительная отладка
while read line
do #подключаем все USB устройства к usbip
echo $line
usbip unbind -b $line
sleep 2 # без пауз адекватно не работает 
usbip bind -b $line
sleep 2
usbip attach -r localhost -b $line
sleep 2
usbip detach -p 00
sleep 2
done < /ram_drive/usb_id.txt #файл, который генерируется каждые 30 секунд