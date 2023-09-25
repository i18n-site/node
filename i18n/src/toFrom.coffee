#!/usr/bin/env coffee

> @8n/lang

< (lang_li, to)=>
  s = new Map
  for [k,li] from Object.entries lang_li
    if li
      for v from li.split ' '
        s.set v,k
    else
      s.set '',k

  to_from = []
  if to
    to_from.push [
      to
      s.get(to) or s.get ''
    ]
  else
    + all
    exist = new Set
    for [to_lang,from_lang] from s.entries()
      exist.add from_lang
      if to_lang
        to_from.push [to_lang, from_lang]
        exist.add to_lang
      else
        all = from_lang

    if all
      for [i] from lang
        if not exist.has i
          to_from.push [i,all]

  to_from
