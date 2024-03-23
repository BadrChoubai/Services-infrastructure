#!/bin/sh
curl http://localhost:9180/apisix/admin/routes/1 -H 'X-API-KEY: abcdefghijklmnopqrstuvwxyz' -X DELETE -s
curl http://localhost:9180/apisix/admin/upstreams/1 -H 'X-API-KEY: abcdefghijklmnopqrstuvwxyz' -X DELETE -s

# https://apisix.apache.org/docs/apisix/tutorials/expose-api/#expose-your-service
(curl http://localhost:9180/apisix/admin/upstreams/1 -s -H 'X-API-KEY: abcdefghijklmnopqrstuvwxyz' -X PUT -d '
{
  "type": "roundrobin",
  "name": "User API",
  "desc": "User API upstream",
  "labels": { "environment": "development", "version": "v1" },
  "nodes": {
      "users-service-v1:8081": 1
  },
  "timeout": {
    "connect": 5,
    "read": 5,
    "send": 5
  },
  "type": "roundrobin"
}')

# Create Route w/ Upstream
(curl http://localhost:9180/apisix/admin/routes/1 -s -H 'X-API-KEY: abcdefghijklmnopqrstuvwxyz' -X PUT -d '
{
  "desc": "User v1 route",
  "host": "users-service-v1",
  "labels": { "environment": "development", "version": "v1" },
  "methods": ["GET"],
  "name": "Users V1",
  "plugin_config_id": 1,
  "status": 1,
  "upstream_id": 1,
  "uri": "/*"
}')


#(curl -i -X GET "http://localhost:8081/health")
(curl -i -X GET "http://localhost:9080/api/v1/users/health")
