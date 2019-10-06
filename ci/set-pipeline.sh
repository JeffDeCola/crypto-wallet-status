#!/bin/bash
# crypto-wallet-status set-pipeline.sh

fly -t ci set-pipeline -p crypto-wallet-status -c pipeline.yml --load-vars-from ../../../../../.credentials.yml
