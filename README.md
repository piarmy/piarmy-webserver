# piarmy-webserver

```
cd /home/pi/images
git clone git@github.com:piarmy/piarmy-webserver.git piarmy-webserver
cd piarmy-webserver
git checkout master
```

Build:
```
docker build -t mattwiater/piarmy-webserver .
```

Run: Interactive mode
```
docker run -it --rm -p 9999:80 --name piarmy-webserver mattwiater/piarmy-webserver /bin/ash
```

Run: detatched mode
```
docker run -d --rm -p 9999:80 --name piarmy-ws-server mattwiater/piarmy-webserver
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