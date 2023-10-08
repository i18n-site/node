#!/usr/bin/env coffee

> ./tranMd.js
  @w5/read
  ./Hash.js

update = (
  new_li
  src_li
  set
  save
)=>
  if new_li.length != src_li.length
    return
  for i, p in src_li
    hash = Hash i
    set hash, new_li[p]
  save()
  return

export default (
  md_fp, txt_li, htm_li
  [tget, tset, tsave]
  [hget, hset, hsave]
) =>
  [tli, hli] = tranMd read md_fp
  update(tli, txt_li, tset, tsave)
  update(hli, htm_li, hset, hsave)
  return
