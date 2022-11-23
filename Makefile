# +optional Platform architecture
ARCH ?= amd64

# +optional Image name during docker-build step
IMG ?= shprakas/rps-$(ARCH)

# +optional Port for serving rock-paper-scissor app from docker host
PORT ?= 8000

# Run tests
.PHONY: test
test:
	python -m pytest

# Build docker image
# Depends on test step
.PHONY: build
build: test
	docker build -t $(IMG) .

# Pushes the built docker image to image registry
# Depends on build step
.PHONY: push
push: build
	docker push $(IMG)

# Run the rock-paper-scissor server inside a docker container
# Depends on build step
# Takes in PORT as input, port on host for port-forwarding
.PHONY: run
run: build
	docker run --rm -d -p $(PORT):12000 $(IMG)	

	
