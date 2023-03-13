#!/bin/sh
# crypto-wallet-status set-pipeline.sh

echo " "
echo "Set pipeline on target jeffs-ci-target which is team jeffs-ci-team"
fly --target jeffs-ci-target \
    set-pipeline \
    --pipeline crypto-wallet-status \
    --config pipeline.yml \
    --load-vars-from ../../../.credentials.yml \
    --check-creds
echo " "
