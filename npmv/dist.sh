#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
. ../../conf/env/cloudflare.sh
set -ex

bun x cf_work_secret -e cf/.dev.vars

./build.sh

cd cf
rm -rf src

bun build ../lib/main.js --minify --outfile src/main.js

nr deploy
