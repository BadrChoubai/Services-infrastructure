# Services Infrastructure

This project contains infrastructure as code resources for deploying an API Gateway with Apache APISIX

> A seperate repository: [Services](https://github.com/BadrChoubai/Services), contains the individual services that are ingested by this project inside of `docker-compose.yaml`

## Setting up a Container Registry Locally

Inside of `/registry`, there is a simple `docker-compose.yaml` file for pulling and running the official Docker Registry image.

Once that's up and running you can start to develop APIs inside of [Services](https://github.com/BadrChoubai/Services) locally 
and push their container images to it so that they can be ingested by this project's own `docker-compose.yaml` (at the root of the project).

### Todos

- [x] Setup service registry for Local services

### Inspired By:

- [Evolving your RESTful APIs, a step-by-step approach](https://blog.frankel.ch/evolve-apis/) - by Nicolas Fränkel, which I saw presented at a recent Meetup ([Colorado Kubernetes and Cloud Native](https://www.meetup.com/colorado-kubernetes-cloud-native/))
