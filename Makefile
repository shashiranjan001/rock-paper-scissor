# +optional Platform architecture
ARCH ?= amd64

# +optional Image name during docker-build step
IMG ?= shprakas/rps-$(ARCH)

# +optional Port for serving rock-paper-scissor app from docker host
PORT ?= 8000

# produce a webpage's archive using mkdockerize(build using dockerfile from this repo) image. It accepts root of a valid mkdocs project and arch of host where image will be run.
.PHONY: test
test:
	python -m pytest

.PHONY: build
build: test
	docker build -t $(IMG) .

.PHONY: push
push: build
	docker push $(IMG)

.PHONY: run
run: build
	docker run --rm -d -p $(PORT):12000 $(IMG)	

	
