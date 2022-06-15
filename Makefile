#!/usr/bin/make

# Docker variables
DOCKERFILE_BUILD ?= ./Dockerfile
DOCKER ?= docker
IMG_NAME ?= shortsite
NO_CACHE ?= --no-cache
MAX_MEM_SWAP ?= 4g
MAX_MEM ?= 2g
MAX_CPU_COUNT ?= 2
CONTAINER_NAME ?= shortsite
WEB_PORT ?= 43881

# Dev GPU
docker-build-dev-gpu:
	@DOCKER_BUILDKIT=1
	@$(DOCKER) build  . --build-arg UID=$(shell id -u) --build-arg GID=$(shell id -g) -f $(DOCKERFILE_BUILD) -t $(IMG_NAME)

# Dev CPU
docker-build-dev-cpu:
	@DOCKER_BUILDKIT=1
	@$(DOCKER) build . --build-arg UID=$(shell id -u) --build-arg GID=$(shell id -g) -f $(DOCKERFILE_BUILD) -t $(IMG_NAME)

docker-start-dev-cpu: docker-build-dev-cpu
	@$(DOCKER) run --privileged -di \
                --rm \
                --cpus=$(MAX_CPU_COUNT) \
                --memory=$(MAX_MEM) \
                --memory-swap=$(MAX_MEM_SWAP) \
                --mount type=bind,source=/tmp/.X11-unix,target=/tmp/.X11-unix \
                --mount type=bind,source=$(PWD),target=/opt/${IMG_NAME} \
                -e DISPLAY=$(DISPLAY) \
		-p $(WEB_PORT):$(WEB_PORT) \
                --hostname $(CONTAINER_NAME) \
                --name $(CONTAINER_NAME) $(IMG_NAME) \
                bash -c "trap : TERM INT; sleep infinity & wait"
	@echo Container Started Successfully...

docker-start-dev-gpu: docker-build-dev-gpu
	@$(DOCKER) run --gpus=all -di \
		--rm \
		--cpus=$(MAX_CPU_COUNT) \
		--memory=$(MAX_MEM) \
		--memory-swap=$(MAX_MEM_SWAP) \
		--mount type=bind,source=/tmp/.X11-unix,target=/tmp/.X11-unix \
		--mount type=bind,source=$(PWD),target=/opt/checrs \
		-e DISPLAY=$(DISPLAY) \
		--hostname $(CONTAINER_NAME) \
		--name $(CONTAINER_NAME) $(IMG_NAME) \
		bash -c "trap : TERM INT; sleep infinity & wait"
	@echo Container Started Successfully...

docker-stop:
	@$(DOCKER) stop $(CONTAINER_NAME)

docker-login:
	@$(DOCKER) exec -it $(CONTAINER_NAME) /bin/bash
