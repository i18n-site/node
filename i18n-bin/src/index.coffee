#!/usr/bin/env coffee

> @8n/lang:LANG
  @w5/utf8/utf8e.js
  path > join
  @w5/write
  @w5/u8 > u8merge

< (pwd, file_li, to_from)=>
  lang_set = new Set
  for li from to_from
    for i from li
      lang_set.add i

  li = []
  for [code, lang] from LANG
    if lang_set.has code
      li.push(
        utf8e code
        [0]
        utf8e lang
      )

  write(
    join(pwd, '.i18n/lang')
    u8merge ...li
  )
  return

if process.argv[1] == decodeURI (new URL(import.meta.url)).pathname
  await main()
  process.exit()

