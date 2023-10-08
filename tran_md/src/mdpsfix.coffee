#!/usr/bin/env coffee

> ./psfix.js

< (src, pos_li)=>

  prefix_suffix = []
  li = []
  for pos from pos_li
    line = src[pos]
    [p,c,s] = psfix line
    prefix_suffix.push [p,s]
    li.push c
  [prefix_suffix, li]
