#!/usr/bin/env coffee

> @8n/htm2md
  @8n/title-case

HTML_ESCAPE = [
  ['&', '&amp;']
  ['<', '&lt;']
  ['>', '&gt;']
]


escape = (str) =>
  for [k,v] from HTML_ESCAPE
    str = str.replaceAll k,v
  str

prefix_title = (prefix, txt)=>
  if prefix.startsWith('#') and not prefix.trimEnd().replaceAll('#','')
    txt = TitleCase txt
  prefix + txt

export default ([
  comment_li
  htm_li
  htm_pos
  code_li
  md
])=>
  for [p,prefix,suffix],n in htm_pos
    md[p] = prefix_title prefix, htm2md(htm_li[n])+suffix

  n = 0
  for [p, code_li, comment_pos_li] from code_li
    for i from comment_pos_li
      code_li[i] = comment_li[n++]
    md[p] = code_li.join('')

  md.join('')

