#!/usr/bin/env coffee

> @8n/srv

console.log srv {
  test: ()->
    console.log @getMethod()
    console.log @getUrl()
    return ['12测']
}
