# Run: Interactive, shell
docker run -it --rm --name=piarmy-alpine mattwiater/piarmy-alpine /bin/bash
ls -laF

# Run: Interactive
docker run -it --rm --name=piarmy-alpine mattwiater/piarmy-alpine

# Run: detatched
docker run -d --rm --name=piarmy-alpine mattwiater/piarmy-alpine