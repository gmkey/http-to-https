$(eval GIT_COMMIT = $(shell git rev-parse HEAD))

ALPINE_VERSION=latest

DOCKER_BASE=gmkey/http-to-https
DOCKER_TAG=latest
DOCKER_TAG2=2.2
default: build

clean:
	rm -f Dockerfile

Dockerfile: Dockerfile.template
	sed \
		-e 's!{{ .AlpineVersion }}!'"$(ALPINE_VERSION)"'!g' \
		-e 's!{{ .Version }}!'"$(DOCKER_TAG)"'!g' \
		-e 's!{{ .GitCommit }}!'"$(GIT_COMMIT)"'!g' \
		Dockerfile.template > Dockerfile

build: Dockerfile
	docker buildx build  --platform linux/amd64,linux/arm64 -t $(DOCKER_BASE):$(DOCKER_TAG) -t $(DOCKER_BASE):$(DOCKER_TAG2) .

run: build
	docker run -it -p80:80 --rm $(DOCKER_BASE):$(DOCKER_TAG)

debug: build
	docker run -it -p80:80 --rm $(DOCKER_BASE):$(DOCKER_TAG) /bin/sh

push: build
	docker push --all-tags $(DOCKER_BASE)
