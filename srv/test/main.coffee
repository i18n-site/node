#!/usr/bin/env coffee

> @8n/srv

console.log srv {
  test: ()->
    console.log @getMethod()
    console.log @getUrl()
    throw new Error '测试'
    return ['12测']
}
