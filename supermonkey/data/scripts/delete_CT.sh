node=$1
cloud=$2

echo "Removing contianer " $node
curl --unix-socket /var/run/docker.sock -X DELETE http:/v1.24/containers/$node?force=1
