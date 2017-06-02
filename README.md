docker build -t mattwiater/piarmy-webserver .

docker run -it --rm -p 9999:80 --name piarmy-webserver mattwiater/piarmy-webserver /bin/ash

docker run -d --rm -p 9999:80 --name piarmy-ws-server mattwiater/piarmy-webserver

# Service mode

docker service create \
  --name=piarmy-webserver \
  --network=piarmy \
  --replicas=4 \
  -p 9999:80 \
  mattwiater/piarmy-webserver:latest