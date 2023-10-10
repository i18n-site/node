#!/usr/bin/env coffee

> @w5/req/reqMsg.js
  @w5/utf8/utf8d.js
  @w5/j2f
  ./Hash.js
  ./noTran.js

API = (process.env.API_3TI_SITE or 'https://api.3Ti.Site')+ '/'

# for i,p in md_li
#   if i and Number.isNaN +i # 纯数字不翻译
#     _md_li.push md_li[p]
#     _pos_li.push pos_li[p]
#     _prefix_suffix.push prefix_suffix[p]

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
    else if noTran i
      traned_li[p] = i
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
  from_lang
  to_lang
  txt_li
  htm_li
  tcache
  hcache
)=>
  txt_li = txt_li or []
  htm_li = htm_li or []

  if from_lang == 'zh' and to_lang == 'zh-TW'
    return [
      txt_li.map j2f
      htm_li.map j2f
    ]
  if hcache
    [hget, hset, hsave] = hcache
    [
      traned_htm_li
      to_tran_htm
      to_tran_htm_pos
    ] = cachedTran(htm_li, hget)
  else
    to_tran_htm = htm_li

  if tcache
    [tget, tset, tsave] = tcache
    [
      traned_txt_li
      to_tran_txt
      to_tran_txt_pos
    ] = cachedTran(txt_li, tget)
  else
    to_tran_txt = txt_li

  if to_tran_htm.length or to_tran_txt.length
    [h,t] = await reqMsg API+'tran', {
      method: 'POST'
      timeout: 1e5
      body:JSON.stringify [
        from_lang
        to_lang
        to_tran_htm
        to_tran_txt
      ]
    }
    if hcache
      merge(
        h
        traned_htm_li
        to_tran_htm
        to_tran_htm_pos
        hset
        hsave
      )
    else
      traned_htm_li = h
    if tcache
      merge(
        t
        traned_txt_li
        to_tran_txt
        to_tran_txt_pos
        tset
        tsave
      )
    else
      traned_txt_li = t
  [
    traned_txt_li
    traned_htm_li
  ]
