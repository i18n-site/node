#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

rm -rf lang.json
curl 'https://api.cognitive.microsofttranslator.com/languages?api-version=3.0' \
  -H 'accept-language: zh-CN,zh;q=0.9,en;q=0.8' >lang.json
