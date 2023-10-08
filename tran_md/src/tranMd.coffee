#!/usr/bin/env coffee

> @8n/replace_n
  @8n/mark
  ./txtSplit.js
  ./mdpsfix.js
  ./codePos.js

< (md)=>
  md = ReplaceN(md)
  [
    src
    pos_li
    code_pos_li
  ] = txtSplit md

  [prefix_suffix, md_li] = mdpsfix(src,pos_li)

  _md_li = []
  _pos_li = []
  _prefix_suffix = []
  for i,p in md_li
    if i and Number.isNaN +i # 纯数字不翻译
      _md_li.push md_li[p]
      _pos_li.push pos_li[p]
      _prefix_suffix.push prefix_suffix[p]


  htm_li = []
  htm_pos = []
  for i,n in _md_li.map(mark).map(
    (i)=>
      if i.charAt(2) == '>'
        i = i.slice(3,-4)
      i
  )
    # if i.indexOf('<') < 0
    #   pos_li = txt_pos
    #   txt_li.push unescape i
    # else
    htm_li.push i
    # htm_txt_li.push _md_li[n]
    p = _pos_li[n]
    delete src[p]
    htm_pos.push [
      p
      ..._prefix_suffix[n]
    ]

  [code_li, comment_li] = codePos(src,code_pos_li)

  [
    comment_li
    htm_li
    htm_pos
    code_li # md_pos, code_first_line, code_li, comment_pos_li
    src
    # htm_txt_li
  ]
