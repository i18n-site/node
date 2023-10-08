> @8n/tran
  @8n/cache
  @8n/nt/load.js
#   @w5/xxhash3-wasm > hash128
#   @w5/bar:Bar
#   @8n/cache_map:CacheMap
#   @w5/write
#   @w5/u8 > u8eq
#   @8n/nt/dump.js
#   path > join
#   fs > readFileSync existsSync
#
cacheNt = cache load

< (dir, relpath, to_lang, from_lang, from_is_change)=>

  from_nt = cacheNt join dir, from_lang, relpath
  if not from_nt
    return

  to_nt = load(join dir, to_lang, relpath) or {}

  [cget, cset, csave] =  CacheMap(
    join dir,'.i18n', from_lang+'.'+to_lang, relpath
  )

  kli = []
  vli = []

  for [k,v] from Object.entries from_nt
    kli.push k
    vli.push v

  # {length} = vli
  # if length
  #   n = 0
  #   bar = Bar(length)
  #   for await to from tranHtm vli, to_lang, from_lang
  #     to_nt[kli[n]] = to
  #     bar()
  #     bar.log '  '+vli[n],'→',to
  #     ++n
  #
  #   dump(
  #     join dir, to_lang, relpath
  #     to_nt
  #   )
  # msave()
  # # console.log to_lang, from_lang, kli, vli
  # return
