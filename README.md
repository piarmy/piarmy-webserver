# piarmy-webserver

```
cd /home/pi/images
git clone git@github.com:piarmy/piarmy-webserver.git piarmy-webserver
cd piarmy-webserver
git checkout master
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
  --replicas=4 \
  -p 9999:80 \
  mattwiater/piarmy-webserver:latest
```