# PiArmy: Alpine Linux Walkthrough
# 2017.06.01
# Matt J. Wiater <matt@brightpixel.com>
# To see all available targets, just type: make
# To build, type: make build
# The build target also runs dependencies in this order: clean -> stop -> build

# Edit only the first value

# A Docker hub account is not required, but we'll be using it in the tutorials.
# This can be whatever you want if you'll just be developing locally.
DOCKER_USERNAME   = mattwiater

# Don't edit below this line

# Best to leave as piarmy-alpine for common namespacing of PiArmy projects
DOCKER_TASKNAME   = piarmy-webserver
DOCKER_IMAGE_NAME = $(DOCKER_USERNAME)/$(DOCKER_TASKNAME)

# Get Image ID and Service ID if they are already running. This will allow us to stop/remove these in subsequent runs
IMAGE_ID          = $(shell docker ps | awk -v pattern=$(DOCKER_TASKNAME) '$$0 ~ pattern{ print $$1 }')
IMAGE_SERVICE_ID  = $(shell docker service ls | awk -v pattern=$(DOCKER_TASKNAME) '$$0 ~ pattern{ print $$1 }') 

# Running make by itself will build the project
default: list

build: stop
	@echo "Building image: $(DOCKER_IMAGE_NAME)"
	@echo "--------------------"
	@docker build -t $(DOCKER_IMAGE_NAME) .
	@echo "--------------------"
	@echo ""

stop: clean
ifeq ($(strip $(IMAGE_SERVICE_ID)),)
	@echo "No matching services found for $(DOCKER_TASKNAME), nothing to do..."
	@echo ""
else
	@echo "Shutting down service: $(DOCKER_TASKNAME)"
	@docker service rm $(DOCKER_TASKNAME) > /dev/null 2>&1
	@echo ""
endif

ifeq ($(IMAGE_ID),)
	@echo "No matching images found for $(DOCKER_TASKNAME), nothing to do..."
	@echo ""
else
	@echo "Removing image: $(IMAGE_ID)"
	@docker rm --force $(IMAGE_ID) > /dev/null 2>&1
	@echo ""
endif

clean:
	clear

	@echo "Removing DS Store files..."
	@echo ""
	$(shell find . -name ".DS_Store" -print0 | xargs -0 rm -rf)
	$(shell find . -name "._*" -print0 | xargs -0 rm -rf)

shell: stop
	@echo "Starting:         $(DOCKER_IMAGE_NAME)"
	@echo "Interactive mode: /bin/bash"
	@echo ""
	@docker run -it --rm --name=$(DOCKER_TASKNAME) $(DOCKER_IMAGE_NAME) /bin/bash

run: stop
	docker service create \
  	--name=$(DOCKER_TASKNAME) \
  	--network=piarmy \
  	--replicas=4 \
  	-p 9999:80 \
  	$(DOCKER_IMAGE_NAME)

push: build
	docker push $(DOCKER_IMAGE_NAME)

	@echo "Pushed: $(DOCKER_IMAGE_NAME)"
	@echo ""

.PHONY: list
list:
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$' | xargs