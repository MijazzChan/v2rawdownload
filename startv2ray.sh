pid=$(ps | awk '/[v]2ray -config/{print $1}')

if [ "$pid" == "" ]; then
    echo "Starting"
else
    echo "Killed and Starting"
    kill $pid
fi

FILE=/opt/bin/v2bin4

if [ -f "$FILE" ]; then

echo "v2ray binary exist"

else

echo "v2ray binary does not exist, try to fetch from web"
curl --retry 2 --retry-delay 2 --connect-timeout 3 'https://gitee.com/MijazzChan/v2rawdownload/raw/master/v2bin4' \
  -o /opt/bin/v2bin4  \
  -H 'Connection: keep-alive' \
  -H 'Referer: https://gitee.com/MijazzChan/v2rawdownload/blob/master/v2bin4' \
  -H 'Cache-Control: no-cache' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36' \
  -H 'DNT: 1' \
  -H 'Accept: */*' \
  --insecure \

fi

if [ -f "$FILE" ]; then

echo "v2ray binary found and located"
/opt/bin/v2bin4 -config /etc/storage/v2rayconfig.json & 

fi  

