DOCKER_USERNAME=mattwiater
DOCKER_TASKNAME=piarmy-webserver
DOCKER_IMAGE_NAME=$(DOCKER_USERNAME)/$(DOCKER_TASKNAME)

# Cleanup DS_Store files
$(shell find . -name ".DS_Store" -print0 | xargs -0 rm -rf)
$(shell find . -name "._*" -print0 | xargs -0 rm -rf)

IMAGE_ID = $(shell docker ps | awk -v pattern=$(DOCKER_TASKNAME) '$$0 ~ pattern{ print $$1 }')
IMAGE_SERVICE_ID = $(shell docker service ls | awk -v pattern=$(DOCKER_TASKNAME) '$$0 ~ pattern{ print $$1 }') 

default: build

build:
	clear

# If matching service is found, remove it
ifeq ($(strip $(IMAGE_SERVICE_ID)),)
	@echo "No matching services found for $(DOCKER_TASKNAME), nothing to do..."
	@echo ""
else
	@echo "Shutting down service: $(DOCKER_TASKNAME)"
	@docker service rm $(DOCKER_TASKNAME) > /dev/null 2>&1
	@echo ""
endif

# If matching image is found, remove it
ifeq ($(IMAGE_ID),)
	@echo "No matching images found for $(DOCKER_TASKNAME), nothing to do..."
	@echo ""
else
	@echo "Removing image: $(IMAGE_ID)"
	@docker rm --force $(IMAGE_ID) > /dev/null 2>&1
	@echo ""
endif
	
	@echo "Building image: $(DOCKER_IMAGE_NAME)"
	@echo "--------------------"
	@docker build -t $(DOCKER_IMAGE_NAME) .
	@echo "--------------------"
	@echo ""

push: build
	docker push $(DOCKER_IMAGE_NAME)

	@echo "Pushed: $(DOCKER_IMAGE_NAME)"
	@echo ""

run:
	# If matching service is found, remove it
ifeq ($(strip $(IMAGE_SERVICE_ID)),)
	@echo "No matching services found for $(DOCKER_TASKNAME), nothing to do..."
	@echo ""
else
	@echo "Shutting down service: $(DOCKER_TASKNAME)"
	@docker service rm $(DOCKER_TASKNAME) > /dev/null 2>&1
	@echo ""
endif

# If matching image is found, remove it
ifeq ($(IMAGE_ID),)
	@echo "No matching images found for $(DOCKER_TASKNAME), nothing to do..."
	@echo ""
else
	@echo "Removing image: $(IMAGE_ID)"
	@docker rm --force $(IMAGE_ID) > /dev/null 2>&1
	@echo ""
endif

	docker service create \
	  --name=piarmy-webserver \
	  --network=piarmy \
	  --replicas=4 \
	  -p 9999:80 \
	  mattwiater/piarmy-webserver