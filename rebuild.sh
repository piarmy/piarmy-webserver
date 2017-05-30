# /bin/bash

find . -name ".DS_Store" -print0 | xargs -0 rm -rf
find . -name "._*" -print0 | xargs -0 rm -rf

docker service rm piarmy-webserver || echo "No running service..." && \
  docker rm --force $(docker ps | awk '/piarmy-webserver/{ print $1 }') || echo "No running image..." && \
  docker build -t mattwiater/piarmy-webserver .  && \
  docker run -d --rm -p 9999:80 --name piarmy-webserver mattwiater/piarmy-webserver && \
  image=$(docker ps | awk '/piarmy-webserver/{ print $1 }') && \
  echo $image

docker commit $image mattwiater/piarmy-webserver
docker push mattwiater/piarmy-webserver
docker rm --force $image

docker service create \
  --name=piarmy-webserver \
  --network=piarmy \
  --replicas=4 \
  -p 9999:80 \
  mattwiater/piarmy-webserver