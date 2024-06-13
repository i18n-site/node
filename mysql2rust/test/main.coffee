#!/usr/bin/env coffee

> @3-/uridir
  path > join
  @3-/read
  ../lib/sqlLi.js


ROOT = uridir import.meta

for table from [
  '3ti'
  'alive'
]
  console.log '→',table
  sql = read join ROOT, table+'.sql'
  for i from sqlLi(sql)
    console.log i
