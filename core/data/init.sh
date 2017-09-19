#!/bin/bash
cat /consul/config2.json | jq ' . | .watches[0].handler = "curl -X PUT -d \""+.domain+"\" \"http://localhost:8500/v1/kv/CONFIG/DNS/domain?token="+.acl_token+"\"" ' > /consul/config.json
