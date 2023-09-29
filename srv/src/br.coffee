> zlib > brotliCompress
  util > promisify

brCompress = promisify(brotliCompress)

< (res, bin)=>
  {length} = bin
  if bin.length > 860
    br = await brCompress bin
    if br.length < length
      bin = br
      res.writeHeader(
        'Content-Encoding', 'br'
      )
  res.end(bin)
  return
