node=$1
cloud=$2

echo "Backup config of " $node
curl -s --unix-socket /var/run/docker.sock -H "Content-Type: application/json" -X GET http:/v1.24/containers/$node/json > /consul/backups/$node.json
