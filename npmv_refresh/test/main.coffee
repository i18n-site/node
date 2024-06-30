#!/usr/bin/env coffee

> @3-/npmv_refresh
  path > join

ROOT = import.meta.dirname
await NpmvRefresh(
  join(
    ROOT
    '../../../ol/conf/nginx/v.i18n.site.mjs'
  )
)
