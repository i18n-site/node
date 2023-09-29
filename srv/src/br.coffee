> zlib > brotliCompress
  util > promisify

brCompress = promisify(brotliCompress)

< (res, status, accept_encoding, bin)=>
  {length} = bin
  if bin.length > 300
    if accept_encoding.includes 'br'
      br = await brCompress bin
      if (20+br.length) < length # 因为 Content-Encoding: br 是 20 字节
        res.cork =>
          res.writeStatus(status).writeHeader(
            'Content-Encoding', 'br'
          ).end br
          return
        return
  res.writeStatus(status).end bin
  return
