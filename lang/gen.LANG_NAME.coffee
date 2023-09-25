#!/usr/bin/env coffee

> ./src/index.js

li = []
for i from index
  li = li.concat i

console.log 'export default '+JSON.stringify li.join('|')
