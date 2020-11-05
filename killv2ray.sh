v2raypid=$(ps | awk '/[v]2ray -config/{print $1}')

if [ "$v2raypid" == "" ]; then
    echo "No v2ray running"
else
    echo $v2raypid
    echo "V2Ray killing"
    kill $v2raypid
fi

