#!/bin/sh
curl http://localhost:9180/apisix/admin/plugin_configs/proxy_rewrite -H 'X-API-KEY: abcdefghijklmnopqrstuvwxyz' -X DELETE
curl http://localhost:9180/apisix/admin/routes/1 -H 'X-API-KEY: abcdefghijklmnopqrstuvwxyz' -X DELETE
curl http://localhost:9180/apisix/admin/upstreams/1 -H 'X-API-KEY: abcdefghijklmnopqrstuvwxyz' -X DELETE

(sh ./onboard_plugins.sh)

# https://apisix.apache.org/docs/apisix/tutorials/expose-api/#expose-your-service
(curl http://localhost:9180/apisix/admin/upstreams/1 -s -H 'X-API-KEY: abcdefghijklmnopqrstuvwxyz' -X PUT -d '
{
  "checks": {
    "active": {
      "http_path": "/health",
      "healthy": {
        "interval": 1,
        "successes": 1
      },
      "unhealthy": {
        "interval": 1,
        "http_failures": 1
      }
    }
  },
  "desc": "upstream to direct traffic to users-service-v1",
  "name": "users-service-v1 upstream",
  "type": "roundrobin",
  "nodes": {
    "users-service-v1:80": 1
  }
}')

# Create Route w/ basic Upstream
# shellcheck disable=SC2016
(curl http://localhost:9180/apisix/admin/routes/1 -s -H 'X-API-KEY: abcdefghijklmnopqrstuvwxyz' -X PUT -d '
{
  "desc": "User v1 route",
  "host": "users-service-v1",
  "labels": { "environment": "development", "version": "v1" },
  "methods": ["GET"],
  "name": "Users V1",
  "plugin_config_id": "proxy_rewrite",
  "status": 1,
  "upstream_id": 1,
  "uri": "/api/v1/users/health*"
}')

echo
echo
echo

#echo "Service HTTP call:"
#(curl -i -X GET "http://localhost:8081/health")
echo "Gateway HTTP call:"
#(curl -i -X GET "http://localhost:9080/health" -H 'Host: users-service-v1')
(curl -i -X GET "http://localhost:9080/api/v1/users/health" -H 'Host: users-service-v1')
