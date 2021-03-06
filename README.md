# crypto-wallet-status

```text
*** THE REPO IS UNDER CONSTRUCTION - CHECK BACK SOON ***
```

[![Go Report Card](https://goreportcard.com/badge/github.com/JeffDeCola/crypto-wallet-status)](https://goreportcard.com/report/github.com/JeffDeCola/crypto-wallet-status)
[![GoDoc](https://godoc.org/github.com/JeffDeCola/crypto-wallet-status?status.svg)](https://godoc.org/github.com/JeffDeCola/crypto-wallet-status)
[![Maintainability](https://api.codeclimate.com/v1/badges/5ffc9029429ce278f688/maintainability)](https://codeclimate.com/github/JeffDeCola/crypto-wallet-status/maintainability)
[![Issue Count](https://codeclimate.com/github/JeffDeCola/crypto-wallet-status/badges/issue_count.svg)](https://codeclimate.com/github/JeffDeCola/crypto-wallet-status/issues)
[![License](http://img.shields.io/:license-mit-blue.svg)](http://jeffdecola.mit-license.org)

_Check all your public cryptocurrency wallets via a webpage (iPhone App coming soon)._

Table of Contents,

* [OVERVIEW](https://github.com/JeffDeCola/crypto-wallet-status#overview)
* [PREREQUISITES](https://github.com/JeffDeCola/crypto-wallet-status#prerequisites)
* [SOFTWARE STACK](https://github.com/JeffDeCola/crypto-wallet-status#software-stack)
* [RUN](https://github.com/JeffDeCola/crypto-wallet-status#run)
* [CREATE BINARY](https://github.com/JeffDeCola/crypto-wallet-status#create-binary)
* [STEP 1 - TEST](https://github.com/JeffDeCola/crypto-wallet-status#step-1---test)
* [STEP 2 - BUILD (DOCKER IMAGE VIA DOCKERFILE)](https://github.com/JeffDeCola/crypto-wallet-status#step-2---build-docker-image-via-dockerfile)
* [STEP 3 - PUSH (TO DOCKERHUB)](https://github.com/JeffDeCola/crypto-wallet-status#step-3---push-to-dockerhub)
* [STEP 4 - DEPLOY (TO MARATHON)](https://github.com/JeffDeCola/crypto-wallet-status#step-4---deploy-to-marathon)
* [CONTINUOUS INTEGRATION & DEPLOYMENT](https://github.com/JeffDeCola/crypto-wallet-status#continuous-integration--deployment)

Documentation and references,

* The
  [crypto-wallet-status](https://hub.docker.com/r/jeffdecola/crypto-wallet-status)
  docker image on DockerHub

[GitHub Webpage](https://jeffdecola.github.io/crypto-wallet-status/)
_built with
[concourse ci](https://github.com/JeffDeCola/crypto-wallet-status/blob/master/ci-README.md)_

## OVERVIEW

Here is an overview of what we're going to do,

![IMAGE - crypto-wallet-status-overview - IMAGE](docs/pics/crypto-wallet-status-overview.jpg)

## PREREQUISITES

I used the following language,

* [go](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/development/languages/go-cheat-sheet)

You will need the following go packages,

```bash
go get -u -v github.com/gorilla/mux
go get -u -v github.com/sirupsen/logrus
```

To build a docker image you will need docker on your machine,

* [docker](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations-tools/orchestration/builds-deployment-containers/docker-cheat-sheet)

To push a docker image you will need,

* [DockerHub account](https://hub.docker.com/)

To deploy to `mesos/marathon` you will need,

* [marathon](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations-tools/orchestration/cluster-managers-resource-management-scheduling/marathon-cheat-sheet)
* [mesos](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations-tools/orchestration/cluster-managers-resource-management-scheduling/mesos-cheat-sheet)

As a bonus, you can use Concourse CI,

* [concourse](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations-tools/continuous-integration-continuous-deployment/concourse-cheat-sheet)

## SOFTWARE STACK

* **GUI**
  _golang net/http package and ReactJS_
* **Routing & REST API framework**
  _golang gorilla/mux package_
* **Backend**
  _golang_
* **Database**
  _N/A_

## RUN

The following steps are located in
[run.sh](https://github.com/JeffDeCola/crypto-wallet-status/blob/master/code/run.sh).

To run
[main.go](https://github.com/JeffDeCola/crypto-wallet-status/blob/master/code/main.go)
from the command line,

```bash
cd code
go run main.go
```

As a placeholder, every 2 seconds it will print,

```txt
    INFO[0000] Let's Start this!
    Hello everyone, count is: 1
    Hello everyone, count is: 2
    Hello everyone, count is: 3
    etc...
```

## CREATE BINARY

The following steps are located in
[create-binary.sh](https://github.com/JeffDeCola/crypto-wallet-status/blob/master/code/bin/create-binary.sh).

```bash
cd code
go build -o bin/crypto-wallet main.go
cd bin
./crypto-wallet
```

This binary will not be used during a docker build
since it creates it's own.

## STEP 1 - TEST

The following steps are located in
[unit-tests.sh](https://github.com/JeffDeCola/crypto-wallet-status/tree/master/code/test/unit-tests.sh).

To unit test the code,

```bash
cd code
go test -cover ./... | tee test/test_coverage.txt
cat test/test_coverage.txt
```

To create `_test` files,

```bash
gotests -w -all main.go
```

## STEP 2 - BUILD (DOCKER IMAGE VIA DOCKERFILE)

The following steps are located in
[build.sh](https://github.com/JeffDeCola/crypto-wallet-status/blob/master/code/build-push/build.sh).

We will be using a multi-stage build using a
[Dockerfile](https://github.com/JeffDeCola/crypto-wallet-status/blob/master/code/build-push/Dockerfile).
The end result will be a very small docker image around 13MB.

```bash
cd code
docker build -f build-push/Dockerfile -t jeffdecola/crypto-wallet-status .
```

You can check and test this docker image,

```bash
docker images jeffdecola/crypto-wallet-status:latest
docker run --name crypto-wallet-status -dit jeffdecola/crypto-wallet-status
docker exec -i -t crypto-wallet-status /bin/bash
docker logs crypto-wallet-status
```

In **stage 1**, rather than copy a binary into a docker image (because
that can cause issues), **the Dockerfile will build the binary in the
docker image.**

If you open the DockerFile you can see it will get the dependencies and
build the binary in go,

```bash
FROM golang:alpine AS builder
RUN go get -d -v
RUN go build -o /go/bin/crypto-wallet-status main.go
```

In **stage 2**, the Dockerfile will copy the binary created in
stage 1 and place into a smaller docker base image based
on `alpine`, which is around 13MB.

## STEP 3 - PUSH (TO DOCKERHUB)

The following steps are located in
[push.sh](https://github.com/JeffDeCola/crypto-wallet-status/blob/master/code/build-push/push.sh).

If you are not logged in, you need to login to dockerhub,

```bash
docker login
```

Once logged in you can push to DockerHub,

```bash
docker push jeffdecola/crypto-wallet-status
```

Check the
[crypto-wallet-status](https://hub.docker.com/r/jeffdecola/crypto-wallet-status)
docker image at DockerHub.

## STEP 4 - DEPLOY (TO MARATHON)

The following steps are located in
[deploy.sh](https://github.com/JeffDeCola/crypto-wallet-status/blob/master/code/deploy-marathon/deploy.sh).

Pull the `crypto-wallet-status` docker image
from DockerHub and deploy to mesos/marathon.

This is actually very simple, you just PUT the
[app.json](https://github.com/JeffDeCola/crypto-wallet-status/blob/master/code/deploy-marathon/app.json)
file to mesos/marathon. This .json file tells marathon what to do.

```bash
cd deploy-marathon
curl -X PUT http://192.168.20.117:8080/v2/apps/crypto-wallet-long-running \
-d @app.json \
-H "Content-type: application/json"
```

## CONTINUOUS INTEGRATION & DEPLOYMENT

Refer to
[ci-README.md](https://github.com/JeffDeCola/crypto-wallet-status/blob/master/ci-README.md)
on how I automated the above steps.
