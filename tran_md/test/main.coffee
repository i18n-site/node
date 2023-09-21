#!/usr/bin/env coffee

> @8n/tran_md
  @w5/uridir
  @w5/read
  path > join
  @w5/write
  fs > existsSync

ROOT = uridir(import.meta)

fp = join(ROOT, 'zh.md')
en_fp = join ROOT,'en.md'

args = [
  'en'
  join(ROOT,'.cache')
]

if existsSync en_fp
  args.push en_fp

en = await TranMd(
  read(fp)
  'zh'
)(
  ...args
)
if args.length == 2
  console.log en
  write(
    en_fp
    en
  )
