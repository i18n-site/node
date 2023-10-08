#!/usr/bin/env coffee

> @w5/utf8/utf8e.js
  @w5/xxhash3-wasm > hash128

< (txt)=>
  txt = utf8e txt
  if txt.length <= 16
    return txt
  return hash128 txt

