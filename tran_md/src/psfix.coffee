#!/usr/bin/env coffee

< default main = (str)=>
  s = str.trimStart()
  prefix = ''.padEnd str.length - s.length
  suffix = ''
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
      s = trimEnd.slice(1,-3)
      suffix = ']:#'
    else
      for i from '-+*'
        if s.startsWith i+' '
          prefix += s.slice(0,2)
          s = s.slice(2)
          break
      if s.startsWith '> '
        prefix += '> '
        s = s.slice(2)
        t = s.trimStart()
        prefix += ''.padEnd(s.length - t.length)
        s = t
      else
        t = s.match /\d+\. /
        if t
          [t] = t
          prefix += t
          s = s.slice(t.length)
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
    '  1'
    '123.  1'
    '[测试]:#'
  ]
    console.log main i

  process.exit()

