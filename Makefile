DOCKER_USER_ID ?=
DOCKER_REPO ?= flask-hello
DOCKER_TAG ?= latest
IMAGE_NAME = ${DOCKER_USER_ID}${"${DOCKER_USER_ID}" != "":?/:}${DOCKER_REPO}:${DOCKER_TAG}
CONTAINER_NAME = flaskhello1
PORT = 8011
CONTAINER_PORT = 8000
PKGNAME ?= flask_hello_world-1.0-py3-none-any.whl

.-include "Makefile.local"

build: .PHONY
	${MAKE} build-app
	${MAKE} build-docker

build-app:
	python -m build --wheel .
	test -f dist/${PKGNAME}

build-docker:
	docker build -t ${IMAGE_NAME} --build-arg HELLOPKG=${PKGNAME} .

run:
	docker run --name=${CONTAINER_NAME} -p ${PORT}:${CONTAINER_PORT} -d ${IMAGE_NAME}

run-foreground:
	docker run --name=${CONTAINER_NAME} -p ${PORT}:${CONTAINER_PORT} ${IMAGE_NAME}

rm:
	docker rm ${CONTAINER_NAME}

rm-image:
	docker image rm ${IMAGE_NAME}

pull:
	docker pull ${IMAGE_NAME}

.if empty(DOCKER_USER_ID)
.for _t in push
${_t}:
	@echo DOCKER_USER_ID is not defined.
	false
.endfor

.else
push:
	docker push ${IMAGE_NAME}
.endif

clean:
	-rm -rf dist build *.egg-info
