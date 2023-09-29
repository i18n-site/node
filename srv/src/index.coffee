
> uWebSockets

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

< (url)=>
  uWebSockets.App({}).any(
    '/*'
    (res, req) =>
      # https://unetworking.github.io/uWebSockets.js/generated/interfaces/HttpRequest.html#getMethod
      console.log req.getMethod()
      console.log req.getUrl()
      res.writeStatus('404').end('')
      return
  ).listen(
    +PORT
    =>
      console.log 'http://127.0.0.1:'+PORT
      return
  )

