#!/usr/bin/env coffee

> ./src/zh
  @w5/tran > tranTxt
  @w5/write

cap = (s)=>
  s.charAt(0).toLocaleUpperCase() + s[1..].toLocaleLowerCase()

out = []
for [code,name] from zh
  li = []
  switch code
    when zh
      local =  name
    when 'ja'
      local = '日本语'
    else
      for await i from tranText name.split('('), code, 'zh'
        li.push cap i
      local = li.join '('
  console.log code, name, local
  out.push [code, local]

write(
  'src/index.js'
  'export default '+JSON.stringify(out)
)
