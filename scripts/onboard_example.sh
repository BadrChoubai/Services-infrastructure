curl -i "http://127.0.0.1:9180/apisix/admin/routes" -H 'X-API-KEY: abcdefghijklmnopqrstuvwxyz' -X PUT -d '
{
  "id": "getting-started-ip",
  "uri": "/ip",
  "upstream": {
    "type": "roundrobin",
    "nodes": {
      "httpbin.org:80": 1
    }
  }
}'

curl "http://127.0.0.1:9080/ip"

curl http://localhost:9180/apisix/admin/routes/getting-started-ip -H 'X-API-KEY: abcdefghijklmnopqrstuvwxyz' -X DELETE
