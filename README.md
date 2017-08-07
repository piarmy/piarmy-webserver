# piarmy-webserver: tutorial02

This tutorial will guide you through running your first webserver on Alpine Linux. We also introduce the Docker Makefile for automating some common commands.

```
cd /home/pi/images
git clone git@github.com:piarmy/piarmy-webserver.git piarmy-webserver
cd piarmy-webserver
git checkout tutorial02
```

Build:
```
make build
```

Run: Interactive mode
```
make shell
```

Run: detatched mode
```
make run
```

# Service mode
```
docker service create \
  --name=piarmy-webserver \
  --network=piarmy \
  --replicas=1 \
  -p 9999:80 \
  mattwiater/piarmy-webserver:latest
```
