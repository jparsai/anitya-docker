# anitya-docker

[Anitya](https://github.com/fedora-infra/anitya) in Docker, use at your own risk

**Note: I included some not-yet upstreamed and even un-upstreamable patches in this repo, since I'm working on project that currently needs this. In the near future, I or someone else from my team will be pushing proper patches to implement the functionality.**

There are three Dockerfiles in this repo, each of them building image of one service: PostgreSQL for Anitya, Anitya server itself and a Cron job that watches upstream repos for new releases and automatically adds them to Anitya. You can pull the images built from this repo from dockerhub:
* https://hub.docker.com/r/slavek/anitya-postgres/
* https://hub.docker.com/r/slavek/anitya-server/
* https://hub.docker.com/r/slavek/anitya-cron/

This repo also includes an example `docker-compose.yml` that brings up all three services. Note that the cron service is optional and you don't need to add it to your setup.

## Running

Run:

```
# Run make only if you want to build the images yourself. You can skip this step,
# in which case docker-compose will pull latest images from dockerhub.
make
docker-compose up
```

And then open your favourite browser and go to http://localhost:31005
