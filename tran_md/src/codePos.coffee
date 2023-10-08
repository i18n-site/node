#!/usr/bin/env coffee
> @8n/comment

< (md, code_pos_li)=>
  r = []
  comment_li = []
  for md_pos from code_pos_li
    code_src = md[md_pos]
    code = code_src.trimEnd()
    more = code_src.slice(code.length)
    code = code.split('\n')
    lang = code[0].slice(3)
    if lang of comment
      code_first_line = code[0]+'\n'
      code_last_line = '\n'+code.at(-1)+more
      [
        code_li
        comment_pos_li
      ] = comment[lang] code.slice(1,-1).join('\n')

      comment_pos_li = comment_pos_li.map (i)=>1+i
      code_li.unshift code_first_line
      code_li.push code_last_line
      r.push [
        md_pos
        code_li
        comment_pos_li
      ]

      comment_li.push ...comment_pos_li.map (i)=>code_li[i]
      delete md[md_pos]
      for i from comment_pos_li
        delete code_li[i]
  [
    r
    comment_li
  ]
