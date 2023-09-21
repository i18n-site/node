#!/usr/bin/env bash
set -e
DIR=$(dirname $(realpath "$0"))

cd $DIR

if [ ! -n "$1" ]; then
  exe=src/index.coffee
else
  exe=${@:1}
fi

exec watchexec --shell=none \
  --project-origin . \
  -w ./src/ \
  -w ./test.coffee \
  --exts coffee,rs,wasm \
  -r \
  -- ./run.sh
