DOCKER_USERNAME=mattwiater
DOCKER_TASKNAME=piarmy-webserver
DOCKER_IMAGE_NAME=$(DOCKER_USERNAME)/$(DOCKER_TASKNAME)

default: build

build:
	clear
	docker service rm $(DOCKER_TASKNAME) > /dev/null 2>&1 || echo "No running service..."
	docker rm --force $$(docker ps | awk "/$${DOCKER_TASKNAME}/{ print $$1 }") || echo "No running image..."
	docker build -t $(DOCKER_IMAGE_NAME) .
	docker run -d --rm -p 9999:80 --name $(DOCKER_TASKNAME) $(DOCKER_IMAGE_NAME)
	image=$(docker ps | awk '/$$DOCKER_TASKNAME/{ print $1 }')

	docker commit $(image) $(DOCKER_IMAGE_NAME)
	docker push $(DOCKER_IMAGE_NAME)
	docker rm --force $(image)

push:
	clear
	echo "Push!"

test:
	clear
	docker ps | awk '/piarmy-webserver/{ print $$1 }'
	docker ps | awk "/$$DOCKER_TASKNAME/{ print $$1 }"
	echo "Test!"
