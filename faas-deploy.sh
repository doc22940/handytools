#!/bin/sh

quasar build -m ssr && \
cd dist/ssr && \
yarn install && \
cd ../../ && \
faas-cli -f faas.yml build && \
faas-cli -f faas.yml push && \
faas-cli -f faas.yml deploy