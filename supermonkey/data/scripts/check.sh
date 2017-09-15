list=$(curl -s 127.0.0.1:8500/v1/agent/checks | jq -r .[].CheckID)

for node in $list; do

if [ $node != "regenerator" ]; then
status=$(curl -s 127.0.0.1:8500/v1/agent/checks | jq -r .$node.Status)

if [ $status != "passing" ]; then
echo $node " -> Down :" $(date)
echo $(date +%Y-%m-%d' '%H:%M)";down;" $node >> '/consul/supermonkey_history.log';

bash /consul/scripts/backup_CT.sh $node
bash /consul/scripts/delete_CT.sh $node
bash /consul/scripts/run_CT.sh $node
else
echo $node " -> OK"
fi

fi
done
