< GOOGLE_MS_SAME = new Set('af am ar as az bg bn bs ca cs cy da de dv el en es et eu fa fi fr ga gl gom gu ha hi hr ht hu hy id ig is it ja ka kk km kn ko ky ln lo lt lv mai mg mi mk ml mr ms mt my ne nl nso or pa pl ps pt ro ru rw sd si sk sl sm sn so sq st sv sw ta te th ti tk tr tt ug uk ur uz vi xh yo zu fil he'.split(' '))
< GOOGLE_MS = {ku:'kmr',ckb:'ku',mn:'mn-Cyrl',hmn:'mww',no:'nb',sr:'sr-Cyrl',zh:'zh-Hans','zh-TW':'zh-Hant'}
export default (code)=>
  if GOOGLE_MS_SAME.has code
    return code
  return GOOGLE_MS[code]
