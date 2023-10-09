#!/usr/bin/env coffee

> @8n/lang:LANG
  @w5/utf8/utf8e.js
  path > join
  @w5/write
  @8n/nt/load.js
  @w5/u8 > u8merge
  @w5/msgpack > pack
  fs > existsSync

< (pwd, file_li, to_from)=>
  public_dir = join pwd, 'public'

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
        [0]
      )

  li.pop()
  write(
    join(public_dir, 'lang')
    u8merge ...li
  )

  site_fp = join pwd, 'site.nt'
  if existsSync site_fp
    site = load site_fp
  else
    site = {}

  for lang from lang_set
    fp = join pwd,lang,'i18n.nt'
    if existsSync fp
      g = load fp
    else
      g = {}
    write(
      join public_dir, lang, '_'
      pack [
        g
        site
      ]
    )
  # 编译 nt
  # for f from file_li
  #   if f.endsWith '.nt'
  #     fp = join pwd, f
  #     if existsSync fp
  #       g = load fp
  #     else
  #       g = {}
  #     for lang from lang_set
  #       write(
  #         join public_dir, lang, f.slice(0,-3)
  #         pack merge(
  #           g
  #           load join pwd, lang, f
  #         )
  #       )
  return

if process.argv[1] == decodeURI (new URL(import.meta.url)).pathname
  await main()
  process.exit()

