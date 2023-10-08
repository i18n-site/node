#!/usr/bin/env coffee


< default main = (s)=>
  prefix = ''
  suffix = ''

  trimStart = =>
    t = s.trimStart()
    diff = s.length - t.length
    if diff > 0
      prefix += ''.padEnd(diff)
      s = t
    return

  trimStart()

  for i,p in s
    if i != '#'
      break

  if p > 0
    prefix += s.slice(0,++p)
    s = s.slice(p)
  else
    trimEnd = s.trimEnd()
    if trimEnd.startsWith('[') and trimEnd.endsWith(']:#')
      prefix = '['
      suffix = s.slice(trimEnd.length-3)
      s = trimEnd.slice(1,-3)
    else
      for i from ['-','+','*','[ ]','[x]']
        if s.startsWith i+' '
          len = i.length + 1
          prefix += s.slice(0,len)
          s = s.slice(len)
          trimStart()

      trimStart()


      if s.startsWith '>'
        prefix += '>'
        s = s.slice(1)
        t = s.trimStart()
        prefix += ''.padEnd(s.length - t.length)
        s = t
      else
        t = s.match /\d+\. /
        if t
          [t] = t
          prefix += t
          s = s.slice(t.length)

  p = length = s.length
  if p
    while p
      c = s.charAt --p
      if not ' \n:'.includes c
        break
    suffix = s.slice(p+1) + suffix
    s = s.slice(0,p+1)

  [
    prefix
    s
    suffix
  ]

if process.argv[1] == decodeURI (new URL(import.meta.url)).pathname
  for i from [
    '## 1'
    '* 1'
    '>   1'
    '>1'
    '  1'
    '-1'
    '123.  1'
    '  - [x] 测试'
    '  - [ ] 测试'
    '    - 段落标题'
    '[测试]:#'
  ]
    console.log main i

  process.exit()

