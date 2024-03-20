# Service Registry Setup

For developing services locally it is recommended that you set up a container registry locally. This project has a `docker-compose.yaml`
file with defaults for setting one up simply by running: `docker compose up`, but feel free to configure it for your needs.

Once you're ready to start to set up the registry, run `docker compose up`. This will create a docker container called
`services-registry-local`.

You can ensure that it's up and running by using the following curl request; you should see a `200` in stdout.
```bash
curl -o /dev/null -s -w "%{http_code}\n" http://localhost:5000

# 200
```
