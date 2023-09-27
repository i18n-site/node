#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

wget "https://api.cognitive.microsofttranslator.com/languages?api-version=3.0" -O lang.json
