pid=$(ps | awk '/[v]2bin4 -config/{print $1}')

if [ "$pid" == "" ]; then
    echo "Starting"
else
    echo "Killed and Starting"
    kill $pid
fi

FILE=/opt/bin/v2bin4
correctmd5=ab5da6a4f96c472906922ec2fa30ef20
currentmd5=`md5sum $FILE | cut -d " " -f1`
if [ -f "$FILE" ] && [ "$correctmd5" = "$currentmd5" ]; then

echo "v2ray binary exist"
chmod +x $FILE
/opt/bin/v2bin4 -config /etc/storage/v2rayconfig.json &

else

echo "v2ray binary does not exist or corrupted, try to fetch from web"
curl --retry 2 --retry-delay 2 --connect-timeout 3 'https://cdn.jsdelivr.net/gh/MijazzChan/v2rawdownload/v2bin4' \
  -o /opt/bin/v2bin4  \
  -H 'Connection: keep-alive' \
  -H 'Cache-Control: no-cache' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36' \
  -H 'DNT: 1' \
  -H 'Accept: */*' \
  --insecure \

chmod +x $FILE

currentmd5=`md5sum $FILE | cut -d " " -f1`

if [ -f "$FILE" ] && [ "$correctmd5" = "$currentmd5" ]; then

echo "v2ray binary found and located"
/opt/bin/v2bin4 -config /etc/storage/v2rayconfig.json & 

else
exit -1
fi  

fi

