#!/usr/bin/env coffee
> ./comment.js

< (md, code_pos_li)=>
  r = []
  for md_code_pos from code_pos_li
    code = md[md_code_pos].trimEnd().split('\n')
    lang = code[0].slice(3)
    if lang of comment
      code0 = code[0]+'\n'
      code_1 = '\n'+code.at(-1)
      [code_li, pos_li] = comment[lang] code.slice(1,-1).join('\n')
      r.push [
        md_code_pos
        code0
        code_1
        code_li
        pos_li
      ]
  r
