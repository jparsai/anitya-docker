CHECKOUT=master

all: build

getsources:
ifeq ($(wildcard anitya/.),)
	git clone https://github.com/fedora-infra/anitya
	git -C anitya checkout $(CHECKOUT)
	find patches/ -name "*.patch" -exec patch -b -d anitya -p1 -i ../{} \;
endif


build: builddbmigrations buildserver

builddbmigrations: getsources Dockerfile.anitya-db-migrations files anitya
	docker build -t slavek/anitya-db-migrations -f Dockerfile.anitya-db-migrations .

buildserver: getsources Dockerfile.anitya-server files anitya
	docker build -t slavek/anitya-server -f Dockerfile.anitya-server .

clean:
	rm -rf anitya/

.PHONY: all getsources clean
