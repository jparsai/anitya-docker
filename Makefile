CHECKOUT=master

all: build

getsources:
ifeq ($(wildcard anitya/.),)
	git clone https://github.com/fedora-infra/anitya
	git -C anitya checkout $(CHECKOUT)
	find patches/ -name "*.patch" -exec patch -b -d anitya -p1 -i ../{} \;
endif


build: buildpostgres buildserver buildcron

buildpostgres: getsources Dockerfile.anitya-postgres files anitya
	docker build -t slavek/anitya-postgres -f Dockerfile.anitya-postgres .

buildserver: getsources Dockerfile.anitya-server files anitya
	docker build -t slavek/anitya-server -f Dockerfile.anitya-server .

buildcron: getsources buildserver Dockerfile.anitya-cron files anitya
	docker build -t slavek/anitya-cron -f Dockerfile.anitya-cron .

clean:
	rm -rf anitya/

.PHONY: all getsources clean
