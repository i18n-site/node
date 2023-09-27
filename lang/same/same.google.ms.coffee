#!/usr/bin/env coffee

> @w5/read
  @w5/uridir
  path > join dirname

ROOT = dirname uridir import.meta

cn2code = new Map
code2cn = new Map

for [code,cn] from (
  await import(
    join(ROOT,'src/zh.coffee')
  )
).default
  cn2code.set cn,code
  code2cn.set code, cn

lang = JSON.parse read join(
  ROOT, 'lang.json'
)


google2ms = {}
rtl = new Set
for [code,{nativeName, name, dir}] from Object.entries lang.translation
  # console.log code, nativeName, dir
  if nativeName.includes '繁體中文'
    nativeName = '简体中文'
  else if nativeName.includes '繁體中文'
    nativeName = '正體中文'
  if code == 'zh-Hans'
    google_code = 'zh'
  else if code == 'zh-Hant'
    google_code = 'zh-TW'
  else if code == 'mn-Cyrl'
    google_code = 'mn'
  else if code == 'mni'
    google_code = 'mni-Mtei'
  else if code == 'nb'
    google_code = 'no'
  else if code == 'fil'
    google_code = 'tl'
  else if code == 'sr-Cyrl'
    google_code = 'sr'
  else
    google_code = code

  if code2cn.has google_code
    google2ms[code] = google_code
    if dir == 'rtl'
      rtl.add google_code
    code2cn.delete google_code
  else
    console.log code, nativeName, name

console.log rtl
console.log code2cn
console.log Object.keys(google2ms).length
