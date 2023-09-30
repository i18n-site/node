> uWebSockets
  @w5/msgpack > pack
  ./br.js
  tough-cookie > Cookie

{
  PORT
} = process.env

< OK = '200'
< NOT_FOUND = '404'
< PORT = +PORT

bind = (ws, name, func)=>
  console.log '/'+name
  ws.any(
    '/'+name
    (res, req)=>
      method = req.getMethod()
      url = req.getUrl()
      content_type = req.getHeader('content-type')
      accept_language = req.getHeader 'accept-language'
      cookie = req.getHeader('cookie')
      if cookie
        cookie = Cookie.parse cookie
      accept_encoding = req.getHeader(
        'accept-encoding'
      )

      opt = {
        content_type
        accept_language
        method
        url
        cookie
      }

      if accept_encoding
        opt.accept_encoding = accept_encoding.split(',').map((i)=>i.trim())


      try
        switch method
          when 'post','put'
            res.onAborted =>
              res.aborted = true
              return
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

        if body and body.length > 0
          if content_type.endsWith '/json'
            body = JSON.parse body
            if Array.isArray body
              r = await func.apply opt, body
            else
              r = await func.call opt, body
          else
            r = await func.call opt, body
        else
          r = await func.call opt

        if r instanceof Function
          await r res
        else
          if r == undefined
            r = ''
          else
            r = pack r
            res_content_type = 'm'
        status = OK
      catch err
        status = '500'
        r = ''+err
        console.error(
          method
          url
          err
        )

      console.log status, method, name
      br(
        res
        status
        accept_encoding
        res_content_type
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
      console.log NOT_FOUND, req.getMethod(), req.getUrl()
      # https://unetworking.github.io/uWebSockets.js/generated/interfaces/HttpRequest.html#getMethod
      res.writeStatus(NOT_FOUND).end('')
      return
  ).listen(
    PORT
    =>
      console.log '→ http://127.0.0.1:'+PORT
      return
  )

