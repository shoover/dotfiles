DISTRO := debian # debian | ubuntu
GITHUB_REF := refs/heads/main
GITHUB_REF_NAME := main

test: test/install test/bootstrap

test/install:
	docker build . --build-arg DISTRO=$(DISTRO) --target install

test/bootstrap:
	docker build . --build-arg DISTRO=$(DISTRO) \
		--build-arg GITHUB_REF=$(GITHUB_REF) \
		--build-arg GITHUB_REF_NAME=$(GITHUB_REF_NAME) \
		--target bootstrap

.PHONY: test test/install test/bootstrap

macos/install: macos/install/bin macos/install/links macos/install/tools

macos/install/bin:
	cd macos; install/bin

macos/install/links:
	cd macos; install/links

macos/install/tools:
	cd macos; install/tools

.PHONY: macos/install macos/install/bin macos/install/links macos/install/tools
