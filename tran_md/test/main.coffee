#!/usr/bin/env coffee

> ../lib/index.js:tranMd
  @w5/uridir
  @w5/read
  @w5/write
  path > join

ROOT = uridir(import.meta)
enfp = join(ROOT,'en.md')
md = await tranMd(
  read join ROOT, 'zh.md'
  'zh'
)(
  'en'
  join ROOT, 'cache.zh.en'
  # enfp
)
write(
  enfp
  md
)
