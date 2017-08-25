CHECKOUT=f3e5d03d64833c74ef765788c513099a2c9e4d69
REGISTRY?=registry.devshift.net
REPOSITORY?=bayesian/anitya-server
DEFAULT_TAG=latest

.PHONY: all docker-build fast-docker-build test get-image-name get-image-repository getsources clean

all: fast-docker-build

docker-build: getsources Dockerfile.anitya-server files anitya
	docker build --no-cache -t $(REGISTRY)/$(REPOSITORY):$(DEFAULT_TAG) -f Dockerfile.anitya-server .

fast-docker-build: getsources Dockerfile.anitya-server files anitya
	docker build -t $(REGISTRY)/$(REPOSITORY):$(DEFAULT_TAG) -f Dockerfile.anitya-server .

get-image-name:
	@echo $(REGISTRY)/$(REPOSITORY):$(DEFAULT_TAG)

get-image-repository:
	@echo $(REPOSITORY)

clean:
	rm -rf anitya/

getsources:
ifeq ($(wildcard anitya/.),)
	git clone https://github.com/fedora-infra/anitya
	git -C anitya checkout $(CHECKOUT)
	find patches/ -name "*.patch" -exec patch -b -d anitya -p1 -i ../{} \;
endif

