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
  console.log '❯',name
  ws.any(
    '/'+name
    (res, req)=>
      try
        r = await f.call req
        if r instanceof Function
          await r res
        else
          if r == undefined
            r = ''
          else
            r = pack r
          res.writeStatus(OK).end(r)
        return
      catch err
        res.writeStatus('500').end(
          ''+err
        )
        console.error(
          req.getMethod()
          req.getUrl()
          err
        )
        return
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

