> zlib > brotliCompress
  util > promisify

brCompress = promisify(brotliCompress)

< (res, status, accept_encoding, content_type, bin)=>
  {length} = bin
  if bin.length > 512
    if accept_encoding?.includes 'br'
      br = await brCompress bin
      if (20+br.length) < length # 因为 Content-Encoding: br 是 20 字节
        content_encoding = 'br'
        bin = br

  if not res.aborted
    res.cork =>
      res.writeStatus(status)
      if content_type
        res.writeHeader 'Content-Type', content_type
      if content_encoding
        res.writeHeader 'Content-Encoding', content_encoding
      res.end br
      return
  return
