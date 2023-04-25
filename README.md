# CRYPTO WALLET STATUS

[![Tag Latest](https://img.shields.io/github/v/tag/jeffdecola/crypto-wallet-status)](https://github.com/JeffDeCola/crypto-wallet-status/tags)
[![Go Reference](https://pkg.go.dev/badge/github.com/JeffDeCola/crypto-wallet-status.svg)](https://pkg.go.dev/github.com/JeffDeCola/crypto-wallet-status)
[![Go Report Card](https://goreportcard.com/badge/github.com/JeffDeCola/crypto-wallet-status)](https://goreportcard.com/report/github.com/JeffDeCola/crypto-wallet-status)
[![codeclimate Maintainability](https://api.codeclimate.com/v1/badges/5ffc9029429ce278f688/maintainability)](https://codeclimate.com/github/JeffDeCola/crypto-wallet-status/maintainability)
[![codeclimate Issue Count](https://codeclimate.com/github/JeffDeCola/crypto-wallet-status/badges/issue_count.svg)](https://codeclimate.com/github/JeffDeCola/crypto-wallet-status/issues)
[![Docker Pulls](https://badgen.net/docker/pulls/jeffdecola/crypto-wallet-status?icon=docker&label=pulls)](https://hub.docker.com/r/jeffdecola/crypto-wallet-status/)
[![MIT License](https://img.shields.io/:license-mit-blue.svg)](https://jeffdecola.mit-license.org)
[![jeffdecola.com](https://img.shields.io/badge/website-jeffdecola.com-blue)](https://jeffdecola.com)

```text
*** THE REPO IS UNDER CONSTRUCTION - CHECK BACK SOON ***
```

_Check all your public cryptocurrency wallets via a webpage (iPhone App coming soon)._

Table of Contents

* [OVERVIEW](https://github.com/JeffDeCola/crypto-wallet-status#overview)
* [PREREQUISITES](https://github.com/JeffDeCola/crypto-wallet-status#prerequisites)
* [SOFTWARE STACK](https://github.com/JeffDeCola/crypto-wallet-status#software-stack)
* [RUN](https://github.com/JeffDeCola/crypto-wallet-status#run)
* [CREATE BINARY](https://github.com/JeffDeCola/crypto-wallet-status#create-binary)
* [STEP 1 - TEST](https://github.com/JeffDeCola/crypto-wallet-status#step-1---test)
* [STEP 2 - BUILD (DOCKER IMAGE VIA DOCKERFILE)](https://github.com/JeffDeCola/crypto-wallet-status#step-2---build-docker-image-via-dockerfile)
* [STEP 3 - PUSH (TO DOCKERHUB)](https://github.com/JeffDeCola/crypto-wallet-status#step-3---push-to-dockerhub)
* [STEP 4 - DEPLOY (TO DOCKER)](https://github.com/JeffDeCola/crypto-wallet-status#step-4---deploy-to-docker)
* [CONTINUOUS INTEGRATION & DEPLOYMENT](https://github.com/JeffDeCola/crypto-wallet-status#continuous-integration--deployment)

Documentation and Reference

* The
  [crypto-wallet-status](https://hub.docker.com/r/jeffdecola/crypto-wallet-status)
  docker image on DockerHub
* [crypto-miner-manager](https://github.com/JeffDeCola/crypto-miner-manager)
* This repos
  [github webpage](https://jeffdecola.github.io/crypto-wallet-status/)
  _built with
  [concourse](https://github.com/JeffDeCola/crypto-wallet-status/blob/master/ci-README.md)_

## OVERVIEW

Here is an overview of what we're going to do,

![IMAGE - crypto-wallet-status-overview - IMAGE](docs/pics/crypto-wallet-status-overview.jpg)

## PREREQUISITES

You will need the following go packages,

```bash
go get -u -v github.com/sirupsen/logrus
go get -u -v github.com/cweill/gotests/...
```

## SOFTWARE STACK

* DEVELOPMENT
  * [go](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/development/languages/go-cheat-sheet)
  * gotests
* OPERATIONS
  * [concourse/fly](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations/continuous-integration-continuous-deployment/concourse-cheat-sheet)
    (optional)
  * [docker](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations/orchestration/builds-deployment-containers/docker-cheat-sheet)
* SERVICES
  * [dockerhub](https://hub.docker.com/)
  * [github](https://github.com/)

Where,

* **GUI**
  _golang net/http package and ReactJS_
* **Routing & REST API framework**
  _golang gorilla/mux package_
* **Backend**
  _golang_
* **Database**
  _N/A_

## RUN

To
[run.sh](https://github.com/JeffDeCola/crypto-wallet-status/blob/master/crypto-wallet-status-code/run.sh),

```bash
cd crypto-wallet-status-code
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

To
[create-binary.sh](https://github.com/JeffDeCola/crypto-wallet-status/blob/master/crypto-wallet-status-code/bin/create-binary.sh),

```bash
cd crypto-wallet-status-code/bin
go build -o crypto-wallet-status ../main.go
./crypto-wallet-status
```

This binary will not be used during a docker build
since it creates it's own.

## STEP 1 - TEST

To create unit `_test` files,

```bash
cd crypto-wallet-status-code
gotests -w -all main.go
```

To run
[unit-tests.sh](https://github.com/JeffDeCola/crypto-wallet-status/tree/master/crypto-wallet-status-code/test/unit-tests.sh),

```bash
go test -cover ./... | tee test/test_coverage.txt
cat test/test_coverage.txt
```

## STEP 2 - BUILD (DOCKER IMAGE VIA DOCKERFILE)

To
[build.sh](https://github.com/JeffDeCola/crypto-wallet-status/blob/master/crypto-wallet-status-code/build/build.sh)
with a
[Dockerfile](https://github.com/JeffDeCola/crypto-wallet-status/blob/master/crypto-wallet-status-code/build/Dockerfile),

```bash
cd crypto-wallet-status-code
docker build -f build/Dockerfile -t jeffdecola/crypto-wallet-status .
```

You can check and test this docker image,

```bash
docker images jeffdecola/crypto-wallet-status:latest
docker run --name crypto-wallet-status -dit jeffdecola/crypto-wallet-status
docker exec -i -t crypto-wallet-status /bin/bash
docker logs crypto-wallet-status
docker rm -f crypto-wallet-status
```

In **stage 1**, rather than copy a binary into a docker image (because
that can cause issues), the Dockerfile will build the binary in the
docker image,

```bash
FROM golang:alpine AS builder
RUN go get -d -v
RUN go build -o /go/bin/crypto-wallet-status main.go
```

In **stage 2**, the Dockerfile will copy the binary created in
stage 1 and place into a smaller docker base image based
on `alpine`, which is around 13MB.

## STEP 3 - PUSH (TO DOCKERHUB)

You must be logged in to DockerHub,

```bash
docker login
```

To
[push.sh](https://github.com/JeffDeCola/crypto-wallet-status/blob/master/crypto-wallet-status-code/push/push.sh),

```bash
docker push jeffdecola/crypto-wallet-status
```

Check the
[crypto-wallet-status docker image](https://hub.docker.com/r/jeffdecola/crypto-wallet-status)
at DockerHub.

## STEP 4 - DEPLOY (TO DOCKER)

To
[deploy.sh](https://github.com/JeffDeCola/crypto-wallet-status/blob/master/crypto-wallet-status-code/deploy/deploy.sh),

```bash
cd crypto-wallet-status-code
docker run --name crypto-wallet-status -dit jeffdecola/crypto-wallet-status
docker exec -i -t crypto-wallet-status /bin/bash
docker logs crypto-wallet-status
docker rm -f crypto-wallet-status
```

## CONTINUOUS INTEGRATION & DEPLOYMENT

Refer to
[ci-README.md](https://github.com/JeffDeCola/crypto-wallet-status/blob/master/ci-README.md)
on how I automated the above steps.
