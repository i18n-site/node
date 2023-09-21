#!/usr/bin/env coffee

export default (pwd, file_li, to_from)=>
  lang = new Set
  for li from to_from
    for i from li
      lang.add i

  console.log lang
  console.log file_li
  console.log pwd
  return

if process.argv[1] == decodeURI (new URL(import.meta.url)).pathname
  await main()
  process.exit()

