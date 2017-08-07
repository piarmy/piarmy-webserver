# piarmy-webserver: tutorial01

This tutorial will guide you through running your first Alpine Linux container on your Raspberry Pi. At this stage, the container does no work, just boots up and and runs the ls command via the last docker run parameter: /bin/bash ls -laF

In the next tutorial, we'll make the container run a webserver.

```
cd /home/pi/images
git clone git@github.com:piarmy/piarmy-webserver.git piarmy-webserver
cd piarmy-webserver
git checkout tutorial01
```

#### Run: Interactive, shell
`docker run -it --rm --name=piarmy-alpine mattwiater/piarmy-alpine /bin/bash
ls -laF`

#### Run: Interactive
`docker run -it --rm --name=piarmy-alpine mattwiater/piarmy-alpine`

#### Run: detatched
`docker run -d --rm --name=piarmy-alpine mattwiater/piarmy-alpine`
