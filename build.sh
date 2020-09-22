#!/usr/bin/env bash

set -Eeuxo pipefail

pushd rlcraft-base
docker build -t rlcraft-base:latest .
popd

pushd shivaxi-rlcraft
docker build -t shivaxi-rlcraft:2.8.2 .
popd

pushd modern-rlcraft
docker build -t modern-rlcraft:1.4.2 .
popd
