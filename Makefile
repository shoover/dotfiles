DISTRO := debian # debian | ubuntu

test: test/install test/bootstrap

test/install:
	docker build . --build-arg DISTRO=$(DISTRO) --target install

test/bootstrap:
	docker build . --build-arg DISTRO=$(DISTRO) --build-arg GITHUB_REF_NAME=main --target bootstrap
