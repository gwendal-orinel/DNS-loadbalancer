#!/bin/sh
chown www-data:www-data /var/run/docker.sock #fix docker rights
if [ $1 ]; then
node=$1

echo "Backup config of " $node
curl -s --unix-socket /var/run/docker.sock -H "Content-Type: application/json" -X GET http:/v1.24/containers/$node/json > /consul/backups/$node.json
else
for node in core checker dnspub; do
echo "Backup config of " $node
curl -s --unix-socket /var/run/docker.sock -H "Content-Type: application/json" -X GET http:/v1.24/containers/$node/json > /consul/backups/$node.json
done
fi
