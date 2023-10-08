#!/usr/bin/env coffee

> ./tranMd.js
  @w5/read
  @w5/utf8/utf8d.js
  @8n/tran/Hash.js
  @8n/tran/noTran.js

update = (
  md_fp
  new_li
  src_li
  [
    get
    set
    save
  ]
)=>
  if new_li.length != src_li.length
    console.warn '⚠️ update cache failed ,', md_fp, 'length not same'
    return

  exist = new Set
  for i, p in src_li
    hash = Hash i
    new_txt = new_li[p]
    if exist.has(i)
      continue
    pre = get(hash)
    if pre
      pre = utf8d pre
    else if noTran(i) and i == new_txt
      continue
    if pre != new_txt
      exist.add i
      set hash, new_txt
  save()
  return

export default (
  md_fp, txt_li, htm_li
  tcache
  hcache
) =>
  [tli, hli] = tranMd read md_fp
  for i from [
    [
      tli, txt_li, tcache
    ]
    [
      hli, htm_li, hcache
    ]
  ]
    update md_fp, ...i
  return
