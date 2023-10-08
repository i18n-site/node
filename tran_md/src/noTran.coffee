#!/usr/bin/env coffee


< default main = (txt)=>
  n = txt.replace(/[\s-_\.\$%\+\*\#]/g,'')
  return ! Number.isNaN Number.parseFloat(n)


if process.argv[1] == decodeURI (new URL(import.meta.url)).pathname
  console.log main '11 - 2 3_4'
  console.log main 'a b c'

