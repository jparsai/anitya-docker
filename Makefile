CHECKOUT=f3e5d03d64833c74ef765788c513099a2c9e4d69

all: build

getsources:
ifeq ($(wildcard anitya/.),)
	git clone https://github.com/fedora-infra/anitya
	git -C anitya checkout $(CHECKOUT)
	find patches/ -name "*.patch" -exec patch -b -d anitya -p1 -i ../{} \;
endif


build: buildserver

buildserver: getsources Dockerfile.anitya-server files anitya
	docker build -t slavek/anitya-server -f Dockerfile.anitya-server .

clean:
	rm -rf anitya/

.PHONY: all getsources clean
