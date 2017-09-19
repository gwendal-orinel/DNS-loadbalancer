#!/bin/bash

#migrate token & domain name into
cat /consul/config.json | jq ' . | .watches[0].handler = "curl -X PUT -d \""+.domain+"\" \"http://localhost:8500/v1/kv/CONFIG/DNS/domain?token="+.acl_token+"\"" ' > /consul/config2.json
mv /consul/config2.json /consul/config.json

#start apache service
/etc/init.d/bind9 start
