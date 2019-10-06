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

* tbd

Documentation and reference,

* tbd

[GitHub Webpage](https://jeffdecola.github.io/crypto-wallet-status/)

## OVERVIEW

tbd

## UPDATE GITHUB WEBPAGE USING CONCOURSE (OPTIONAL)

For fun, I use concourse to update
[crypto-wallet-status GitHub Webpage](https://jeffdecola.github.io/crypto-wallet-status/)
and alert me of the changes via repo status and slack.

A pipeline file [pipeline.yml](https://github.com/JeffDeCola/crypto-wallet-status/tree/master/ci/pipeline.yml)
shows the entire ci flow. Visually, it looks like,

![IMAGE - crypto-wallet-status concourse ci pipeline - IMAGE](docs/pics/crypto-wallet-status-pipeline.jpg)

The `jobs` and `tasks` are,

* `job-readme-github-pages` runs task
  [readme-github-pages.sh](https://github.com/JeffDeCola/crypto-wallet-status/tree/master/ci/scripts/readme-github-pages.sh).

The concourse `resources types` are,

* `crypto-wallet-status` uses a resource type
  [docker-image](https://hub.docker.com/r/concourse/git-resource/)
  to PULL a repo from github.
* `resource-slack-alert` uses a resource type
  [docker image](https://hub.docker.com/r/cfcommunity/slack-notification-resource)
  that will notify slack on your progress.
* `resource-repo-status` uses a resource type
  [docker image](https://hub.docker.com/r/dpb587/github-status-resource)
  that will update your git status for that particular commit.

For more information on using concourse for continuous integration,
refer to my cheat sheet on [concourse](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations-tools/continuous-integration-continuous-deployment/concourse-cheat-sheet).
