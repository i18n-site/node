> uWebSockets
  @w5/msgpack > pack
  ./br.js

{
  PORT
} = process.env

< OK = '200'
< PORT = +PORT

bind = (ws, name, f)=>
  console.log '/'+name
  ws.any(
    '/'+name
    (res, req)=>
      method = req.getMethod()
      url = req.getUrl()
      content_type = req.getHeader('content-type')
      accept_encoding = req.getHeader('accept-encoding').split(',').map((i)=>i.trim())

      opt = {
        content_type
        accept_encoding
        method
        url
      }

      res.onAborted =>
        res.aborted = true
        return

      try
        switch method
          when 'post','put'
            body = await new Promise (resolve)=>
              li = []
              res.onData(
                (buf, isLast) =>
                  if buf.byteLength > 0
                    li.push Buffer.from(buf)
                  if isLast
                    if li.length > 0
                      li = Buffer.concat li
                    resolve li
                  return
              )
              return
            if body.length > 0
              if content_type.endsWith '/json'
                body = JSON.parse body
                if Array.isArray body
                  r = await f.apply opt, body
                else
                  r = await f.call opt, body
              else
                r = await f.call opt, body
            else
              r = await f.call opt
          else
            r = await f.call opt
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
        br(
          res
          status
          accept_encoding
          r
        )
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
    PORT
    =>
      console.log '→ http://127.0.0.1:'+PORT
      return
  )

