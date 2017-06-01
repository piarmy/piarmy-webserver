FROM armhf/alpine

RUN apk update && apk upgrade && \
  apk add --no-cache \
  sudo bash

RUN echo "docker ALL=(ALL) ALL" | tee -a /etc/sudoers && \
  adduser -S -s /bin/bash docker && \
  echo "docker:docker" | chpasswd

USER docker

WORKDIR /home/docker

CMD ["ls", "-laF"]