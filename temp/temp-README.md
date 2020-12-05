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

* [PREREQUISITES](https://github.com/JeffDeCola/crypto-wallet-status#prerequisites)
* [SOFTWARE STACK](https://github.com/JeffDeCola/crypto-wallet-status#software-stack)
* [OVERVIEW](https://github.com/JeffDeCola/crypto-wallet-status#overview)

Documentation and reference,

* tbd

[GitHub Webpage](https://jeffdecola.github.io/crypto-wallet-status/)
_built with
[concourse ci](https://github.com/JeffDeCola/crypto-wallet-status/blob/master/ci-README.md)_

## PREREQUISITES

```bash
go get -u -v github.com/gorilla/mux
go get -u -v github.com/sirupsen/logrus
```

## SOFTWARE STACK

* **GUI**
  _golang net/http package and ReactJS_
* **Routing & REST API framework**
  _golang gorilla/mux package_
* **Backend**
  _golang_
* **Database**
  _N/A_

You may need to,

```bash
go get -u -v github.com/gorilla/mux
```

## OVERVIEW

Here is an overview of what we're going to do,

![IMAGE - crypto-wallet-status-overview - IMAGE](docs/pics/crypto-wallet-status-overview.jpg)
