> uWebSockets
  @w5/msgpack > pack

{
  PORT
} = process.env

###

uWebSockets 参考 SRFNStack 的用法
https://github.com/SRFNStack/spliffy/tree/master/src

返回值
this 就是 req
如果是一个函数，那么会传入 res
会被 msgpack 下

###

# if r instanceof Function
#   r(res)
# else

OK = '200'

bind = (ws, name, f)=>
  console.log '/',name
  ws.any(
    '/'+name
    (res, req)=>
      method = req.getMethod()
      url = req.getUrl()
      res.onAborted =>
        res.aborted = true
        return

      switch method
        when 'post'
          await new Promise (resolve)=>
            res.onData(
              (buf, isLast) =>
                if buf.byteLength > 0
                  console.log Buffer.from(buf)
                if isLast
                  resolve()
                return
            )
            return

      try
        r = await f.apply(
          {
            method
            url
          }
          []
        )
        if r instanceof Function
          await r res
        else
          if r == undefined
            r = ''
          else
            r = pack r
        status = OK
      catch err
        status = '500'
        r = ''+err
        console.error(
          method
          url
          err
        )
      if not res.aborted
        res.writeStatus(status).end(r)
      return
  )
  return

< (route)=>
  ws = uWebSockets.App({})

  for [name,f] from Object.entries(route)
    bind(ws, name, f)

  ws.any(
    '/*'
    (res, req) =>
      # https://unetworking.github.io/uWebSockets.js/generated/interfaces/HttpRequest.html#getMethod
      # console.log req.getMethod()
      # console.log req.getUrl()
      res.writeStatus('404').end('')
      return
  ).listen(
    +PORT
    =>
      console.log 'http://127.0.0.1:'+PORT
      return
  )

