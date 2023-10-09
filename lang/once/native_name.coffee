#!/usr/bin/env coffee

> @w5/read
  @w5/uridir
  path > join
  @w5/split
  ../lib/zh.js

CODE = new Set

for i from zh
  CODE.add i[0]

ROOT = uridir(import.meta)

htm = (read join ROOT, 'locale_coverage.html').split('<tr>')

en_name_li = []
native_name_li = []

prefix = '''<td class='source'><a name=\''''
for i from htm
  i = i.trim()
  if i.startsWith(prefix)
    p = i.lastIndexOf('</tr>')
    i = i.slice(prefix.length, p).split('</td>')
    [code, en, native_name] = i
    code = code.slice(0,code.indexOf('\''))
    switch code
      when 'zh_Hant'
        code = 'zh-TW'

    if CODE.has code
      console.log code, en, native_name
      CODE.delete code
console.log CODE

# li = []
# t = []
# for i from read(join(ROOT, 'locale.txt')).split('\n')
#   i = i.trim().slice(3,-4)
#   if not i
#     continue
#   [ k,v ] = split i,':'
#   if k.endsWith ' Name'
#     k = k.slice(0,-5)
#   t.push [k.trim(),v.trim()]
#   if k == 'English'
#     li.push t
#     t = []
#
# native_name = []
# en_name = []
# push = (id, i)=>
#   CODE.delete id
#   for [li, key] from [
#     [
#       native_name, 'Native'
#     ]
#     [
#       en_name, 'English'
#     ]
#   ]
#     li.push [
#       id
#       split(i.get(key),'(')[0].trim()
#     ]
#   return
#
# for i from li
#   if i.length == 3
#     i = new Map i
#     id = i.get('Id')
#     if CODE.has id
#       push id, i
#       continue
#     id = split(id,'-')[0]
#     if CODE.has id
#       push id, i
#
# console.log CODE
# console.log native_name.length
