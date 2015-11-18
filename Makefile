build: build6 build7 build8

push:
	docker push quay.io/goodguide/oracle-java:6
	docker push quay.io/goodguide/oracle-java:7
	docker push quay.io/goodguide/oracle-java:8

pull-base:
	docker pull quay.io/goodguide/base

build6: pull-base
	docker build -t quay.io/goodguide/oracle-java:6 --build-arg JAVA_VERSION=6 .
build7: pull-base
	docker build -t quay.io/goodguide/oracle-java:7 --build-arg JAVA_VERSION=7 .
build8: pull-base
	docker build -t quay.io/goodguide/oracle-java:8 --build-arg JAVA_VERSION=8 .

.PHONY: build build6 build7 build8 push
