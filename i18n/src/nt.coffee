> @8n/tran
  @w5/xxhash3-wasm > hash128
  @8n/cache
  @w5/bar:Bar
  @8n/cache_map:CacheMap
  @w5/write
  @w5/u8 > u8eq
  @8n/nt/dump.js
  @8n/nt/load.js
  path > join
  fs > readFileSync existsSync

cacheNt = cache load

< (dir, relpath, to_lang, from_lang)=>

  from_nt = cacheNt join dir, from_lang, relpath

  if not from_nt
    return

  to_nt = load(join dir, to_lang, relpath) or {}

  [mget,mset,msave]=  CacheMap(
    join dir,'.i18n', from_lang+'.'+to_lang, relpath
  )

  kli = []
  vli = []

  for [k,v] from Object.entries from_nt
    hash = hash128(v)
    if k of to_nt
      pre = mget(k)
      if pre and u8eq pre,hash
        continue
    mset k,hash
    kli.push k
    vli.push v

  {length} = vli
  if length
    n = 0
    bar = Bar(length)
    for to from (await tran(from_lang, to_lang, [], vli))[1]
      to_nt[kli[n]] = to
      bar()
      bar.log from_lang+' → '+to_lang+' '+vli[n]+' → '+to
      ++n

    dump(
      join dir, to_lang, relpath
      to_nt
    )
  msave()
  return
