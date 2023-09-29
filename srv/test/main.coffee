#!/usr/bin/env coffee

> @8n/srv

console.log srv {
  test: (body)->
    console.log @
    console.log 'body', body
    return ['12测']
}
