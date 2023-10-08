#!/usr/bin/env coffee

> zx/globals:
  @w5/uridir
  @w5/req/reqMsg
  ./Hash.js
  @w5/utf8/utf8d.js

API = (process.env.I18N_SITE_API or 'https://api.i18n.site')+ '/'

cachedTran = (
  li
  get
)=>
  to_tran = []
  to_tran_pos = []
  traned_li = []
  for i,p in li
    hash = Hash i
    pre = get(hash)
    if pre != undefined
      traned_li[p] = utf8d pre
    else
      to_tran.push i
      to_tran_pos.push p

  [
    traned_li
    to_tran
    to_tran_pos
  ]


merge = (
  li
  traned_li
  to_tran
  to_tran_pos
  set
  save
)=>
  for i,n in li
    set Hash(to_tran[n]), i
    traned_li[
      to_tran_pos[n]
    ] = i
  save()
  return


export default (
  from_lang, to_lang
  txt_li
  htm_li
  [tget, tset, tsave]
  [hget, hset, hsave]
)=>

  [
    traned_htm_li
    to_tran_htm
    to_tran_htm_pos
  ] = cachedTran(htm_li, hget)
  [
    traned_txt_li
    to_tran_txt
    to_tran_txt_pos
  ] = cachedTran(txt_li, tget)

  if to_tran_htm.length or to_tran_txt.length
    [h,t] = await reqMsg API+'tran', {
      method: 'POST'
      body:JSON.stringify [
        from_lang
        to_lang
        to_tran_htm
        to_tran_txt
      ]
    }
    merge(
      h
      traned_htm_li
      to_tran_htm
      to_tran_htm_pos
      hset
      hsave
    )
    merge(
      t
      traned_txt_li
      to_tran_txt
      to_tran_txt_pos
      tset
      tsave
    )

  [
    traned_txt_li
    traned_htm_li
  ]
