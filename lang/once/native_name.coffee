#!/usr/bin/env coffee

> @w5/read
  @w5/utf8/utf8d
  @w5/utf8/utf8e
  @w5/uridir
  path > join dirname
  @w5/split
  ../src/zh.coffee
  @w5/write


CODE = new Map zh

CODE_ID = new Map

for i, p in zh
  CODE_ID.set i[0],p

ROOT = uridir(import.meta)
SRC = join dirname(ROOT),'src'
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
      when 'mni'
        code = 'mni-Mtei'
      when 'hnj'
        code = 'hmn'
    if CODE.get code
      en = en.split('>').pop()
      native_name = native_name.split('>').pop()
      en_name_li.push [code, en]
      switch native_name
        when '中文'
          native_name = '简体中文'
        when '繁體中文'
          native_name = '正體中文'
      native_name_li.push [code, native_name]
      CODE.delete code

for {
  code
  native_name
  english_name
} from [
  {
    "code": "ay",
    "english_name": "Aymara",
    "native_name": "Aymar aru"
  },
  {
    "code": "gom",
    "english_name": "Konkani",
    "native_name": "गोंयची कोंकणी"
  },
  {
    "code": "ht",
    "english_name": "Haitian Creole",
    "native_name": "Kreyòl ayisyen"
  },
  {
    "code": "lus",
    "english_name": "Mizo",
    "native_name": "Mizo ṭawng"
  },
  {
    "code": "sm",
    "english_name": "Samoan",
    "native_name": "Gagana fa'a Sāmoa"
  },
  {
    "code": "ilo",
    "english_name": "Ilokano",
    "native_name": "Pagsasao Ilokano"
  }
]
  if CODE.get code
    CODE.delete code
    en_name_li.push [code, english_name]
    native_name_li.push [code, native_name]


dump = (name, li)=>
  for i from li
    i[1] = utf8d(utf8e i[1]).trim()
    if i[1].startsWith '\u202b'
      console.log i[0]
  li.sort(
    (a,b)=>
      CODE_ID.get(a[0]) - CODE_ID.get(b[0])
  )
  write(
    join SRC,name+'.js'
    'export default '+JSON.stringify(li,null,2)
  )

dump 'index', native_name_li
dump 'en', en_name_li
