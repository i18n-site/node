#!/usr/bin/env coffee

> @8n/srv

console.log srv(
  {
    test: (body)->
      # console.log @
      # console.log 'body', body
      await new Promise (resolve)=>
        setTimeout(resolve,100)
        return
      console.log 'return'
      return ['为了将 zlib 的 brotliCompress 函数转换为一个可以使用 await 的异步函数为了将 zlib 的 brotliCompress 函数转换为一个可以使用 await 的异步函数为了将 zlib 的 brotliCompress 函数转换为一个可以使用 await 的异步函数为了将 zlib 的 brotliCompress 函数转换为一个可以使用 await 的异步函数为了将 zlib 的 brotliCompress 函数转换为一个可以使用 await 的异步函数']
  }
)
