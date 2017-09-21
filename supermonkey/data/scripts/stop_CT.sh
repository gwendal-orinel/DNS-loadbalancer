#!/bin/bash
list=$(curl -s 127.0.0.1:8500/v1/agent/checks | jq -r .[].CheckID)

if [ -z $1 ]; then
srv_list=($list)
delete=(regenerator)
srv_list=( "${srv_list[@]/$delete}" )
nb_srv=${#srv_list[@]};
nb_srv=$(($nb_srv-1))
rand=$(date +%S)
cpt=0
killed=""
i=0

while [ $cpt -le $rand ]; do
killed=${srv_list[$i]}
i=$(($i+1))
cpt=$(($cpt+1))
if [ $i == $nb_srv ]; then i=0 ;fi
done
node=$killed

else
node=$1
fi

echo $node
curl --unix-socket /var/run/docker.sock -X POST http:/v1.24/containers/$node/stop

if [ $1 ]; then
    echo $(date +%Y-%m-%d' '%H:%M)";humankill;"$node >> '/consul/supermonkey_history.log';
else
    echo $(date +%Y-%m-%d' '%H:%M)";kill;"$node >> '/consul/supermonkey_history.log';
fi
