#рестарт прописанных русками устройств
usbip unbind -b 4-2.4
sleep 2
usbip bind -b 4-2.4
sleep 2
usbip attach --remote=localhost --busid=4-2.4
sleep 2
usbip detach --port=00
#usbip unbind -b 3-1
#sleep 2
#usbip bind -b 3-1
#sleep 2
#usbip attach --remote=localhost --busid=3-1
#sleep 2
#usbip detach --port=00
