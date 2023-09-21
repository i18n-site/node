#!/usr/bin/env coffee

> ./index.js
  yargs

{
  argv
} = yargs(process.argv.slice(2))
  .alias('t', 'to')
  .describe('to','only translate to this language').help()

try
  await index(
    process.env.WORKDIR \
    or \
    process.cwd()
    argv.to
  )
  code = 0
catch err
  console.trace err
  code = 1
process.exit(code)
