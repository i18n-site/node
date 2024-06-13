#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

d() {
  direnv exec . $1
}

d ./rust.coffee
d ./case.coffee
d ./code_id.coffee
d ./nospcae.coffee
