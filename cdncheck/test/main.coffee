#!/usr/bin/env coffee

> @3-/cdncheck

console.log await cdncheck(
  'i18n.site'
  '.i'
  [
    '110.53.110.41'
    '172.67.203.142'
  ]
)
