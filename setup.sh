#!/usr/bin/env bash
git clone https://github.com/phacility/libphutil.git \
  && git clone https://github.com/phacility/arcanist.git \
  && git clone https://github.com/phacility/phabricator.git
docker-compose build
docker-compose up
