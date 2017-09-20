#!/bin/bash

#create domain key in consul kv
DOMAINKEY=$(cat /consul/config.json | jq -r ' . | {domain: .domain,token: .acl_token}| "curl -X PUT -d \""+.domain+"\" http://localhost:8500/v1/kv/CONFIG/DNS/domain?token="+.token+"" ')
$DOMAINKEY

#start apache service
/etc/init.d/bind9 start


#Keep container launched & views logs
/bin/consul monitor
