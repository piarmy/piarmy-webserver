FROM armhf/alpine

RUN apk update && apk upgrade && \
  apk add --no-cache \
  sudo bash

RUN echo "docker ALL=(root) NOPASSWD:ALL" | tee -a /etc/sudoers && \
  adduser -S -s /bin/bash docker && \
  echo "docker:docker" | chpasswd

USER docker

COPY containerFiles /www

WORKDIR /www

EXPOSE 80

CMD ["sudo", "httpd", "-f", "-p", "80", "-h", "/www"]