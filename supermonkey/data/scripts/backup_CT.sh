#!/bin/sh
#init log file and fix php/docker permissions
touch /consul/supermonkey_history.log
chown www-data:www-data /consul/supermonkey_history.log
chown www-data:www-data /var/run/docker.sock

if [ $1 ]; then
node=$1

#old volume is binded to backup for recovery old data
echo "Backup config of " $node
curl -s --unix-socket /var/run/docker.sock -H "Content-Type: application/json" -X GET http:/v1.24/containers/$node/json | jq -c '. | if(.Mount != null) then .HostConfig.Binds = [.Mounts[0].Name+":"+.Mounts[0].Destination ] else . end' > /consul/backups/$node.json
else
for node in core checker dnspub; do
echo "Backup config of " $node
curl -s --unix-socket /var/run/docker.sock -H "Content-Type: application/json" -X GET http:/v1.24/containers/$node/json | jq -c '. | if(.Mount != null) then .HostConfig.Binds = [.Mounts[0].Name+":"+.Mounts[0].Destination ] else . end' > /consul/backups/$node.json
done
fi
