#!/bin/sh
(curl http://localhost:9180/apisix/admin/plugin_configs/proxy_rewrite -H 'X-API-KEY: abcdefghijklmnopqrstuvwxyz' -X DELETE)

curl http://localhost:9180/apisix/admin/plugin_configs/proxy_rewrite -H 'X-API-KEY: abcdefghijklmnopqrstuvwxyz' -X PUT -d '
{
  "plugins": {
    "proxy-rewrite": {
      "regex_uri": ["/api/v1/users(.*)", "$1"]
    }
  }
}'
