#!/usr/bin/env bash

set -ex
if [ -z "$1" ]; then
  echo "USAGE : $0 project_name"
  exit 1
else
  cd $1
fi
exec /opt/bin/npmv_refresh.js ../../conf/nginx/v.i18n.site.mjs
