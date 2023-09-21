#!/usr/bin/env coffee

> ./loads.js
  @w5/read
  fs > existsSync

< (fp)=>
  if not existsSync fp
    return
  loads read fp
