#!/usr/bin/env coffee

> @w5/fetch/fBin

+ PREFIX

< setPrefix =  (p)=>
  PREFIX = p
  return

< (url, args...)=>
  fBin(
    PREFIX + url
    ...args
  )

