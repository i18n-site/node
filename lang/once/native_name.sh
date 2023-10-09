#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

rm locale_coverage.html
wget https://www.unicode.org/cldr/charts/43/supplemental/locale_coverage.html

./native_name.coffee
# rm locale.htm
# wget https://support.google.com/appsheet/answer/11579290 -O locale.htm
# cat locale.htm | rg ">Id:|Native Name|English Name" | tee locale.txt
# ./native_name.coffee
