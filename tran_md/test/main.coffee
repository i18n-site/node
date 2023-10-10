#!/usr/bin/env coffee

> ../lib/index.js:tranMd
  @w5/uridir
  @w5/read
  @w5/write
  path > join

ROOT = uridir(import.meta)
lang = 'en'
langfp = join(ROOT,lang+'.md')
form_lang = 'zh'
md = await tranMd(
  read join ROOT, form_lang+'.md'
  form_lang
)(
  lang
  join ROOT, 'cache.'+form_lang+'.'+lang
  # langfp
)
console.log md
if md
  write(
    langfp
    md
  )
