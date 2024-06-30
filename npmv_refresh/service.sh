#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

bun i

./build.sh

BIN=/opt/bin/npmv_refresh.mjs

echo -e "#!/usr/bin/env -S node --trace-uncaught --expose-gc --unhandled-rejections=strict\n$(bun build ./lib/main.js --minify --target=node)" >$BIN

chmod +x $BIN

NAME=$(basename $DIR)

cp $NAME.sh /opt/bin/

add_service.sh $NAME
