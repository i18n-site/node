> ./merge.js
  ./codePos.js
  @w5/xxhash3-wasm > hash128
  @8n/replace_n
  @w5/read

< (from_lang, mget, mset, src, update_cache_fp)=>
  [
    md
    md_pos_li
    md_code_pos_li
  ] = merge ReplaceN(read update_cache_fp)
  if md.length == src.length
    for pos from md_pos_li
      i = src[pos]
      key = hash128 i
      if mget key
        mset key,md[pos]

    md_code_li = codePos(md, md_code_pos_li)

    for [md_code_pos, code0, code_1, code_li, pos_li],li_pos in codePos(src, md_code_pos_li)
      md_code = md_code_li[li_pos].at -2
      for pos from pos_li
        i = code_li[pos]
        key = hash128 'code\r'+i
        if mget key
          mset key, md_code[pos]
  else
    console.warn "⚠️ Failed Update Cache",update_cache_fp,"length != #{from_lang}.length"
  return
  # for [md_code_pos, code0, code_1, code_li, pos_li] from codePos(
  #   md
  #   code_pos_li
  # )
