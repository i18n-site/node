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
miss_in_google = new Map
for [code,{nativeName, name, dir}] from Object.entries lang.translation
  # console.log code, nativeName, dir
  if nativeName.includes '繁體中文'
    nativeName = '简体中文'
  else if nativeName.includes '繁體中文'
    nativeName = '正體中文'
  switch code
    when 'zh-Hans'
      google_code = 'zh'
    when 'zh-Hant'
      google_code = 'zh-TW'
    when 'mn-Cyrl'
      google_code = 'mn'
    # when 'mni'
    #   google_code = 'mni-Mtei'
    when 'nb'
      google_code = 'no'
    when 'fil'
      google_code = 'tl'
    when 'ku'
      google_code = 'ckb'
    when 'kmr'
      google_code = 'ku'
    when 'sr-Cyrl'
      google_code = 'sr'
    when 'mww'
      google_code = 'hmn'
    when 'he'
      google_code = 'iw'
    else
      google_code = code

  console.log code, nativeName, name
  if code2cn.has google_code
    google2ms[code] = google_code
    if dir == 'rtl'
      rtl.add google_code
    code2cn.delete google_code
  else
    miss_in_google.set code,name

console.log rtl
console.log code2cn
console.log miss_in_google
console.log Object.keys(google2ms).length
