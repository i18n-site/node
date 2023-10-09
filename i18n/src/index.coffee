#!/usr/bin/env coffee

> ./nt.js
  ./md.js
  ./toFrom.js
  @8n/cache
  @w5/ext
  @w5/bar:Bar
  @w5/walk > walkRel
  @8n/is-change
  @8n/nt:Nt
  fs > statSync existsSync
  path > join


I18N_NT = 'i18n.nt'

< (pwd, to)=>
  {i18n} = Nt(pwd)
  to_from = toFrom i18n.lang, to

  [isChange,changeSave] = IsChange(
    join pwd,'.i18n'
    pwd
  )

  changed = new Set

  + all_file

  fileLi = cache (dir)=>
    r = []
    for await fp from walkRel(
      dir
      (i)=>
        i.startsWith('.') or i == 'node_modules'
    )
      e = ext fp
      if e != 'md'
        continue
      r.push fp
      all_file = r
    r

  bar = Bar to_from.length
  for [to_lang,from_lang] from to_from
    bar()
    from_dir = join pwd, from_lang
    if not existsSync from_dir
      continue

    file_li = await fileLi from_dir
    i18n_nt = join(
      from_dir
      I18N_NT
    )
    run = [
      [
        md, file_li
      ]
    ]
    if existsSync join from_dir, I18N_NT
      run.push [
        nt
        [I18N_NT]
      ]

    for [func, fp_li] from run
      for fp from fp_li
        from_rel = join from_lang,fp
        to_rel = join to_lang, fp
        from_fp = join pwd, from_rel
        to_fp = join pwd, to_rel
        from_change = isChange(from_rel)
        if from_change or isChange(to_rel)
          bar.log from_lang, '→', to_lang
          await func(
            pwd
            fp
            to_lang
            from_lang
            from_change
          )
          changed.add to_rel
  if not to # 不然可能缓存了中间态，比如中译英，英还没译为其他，但是已经缓存了英文的哈希
    changeSave changed
    for i from (i18n.on?.end or [])
      await (await import(i)).default(pwd, all_file, to_from)
  return
