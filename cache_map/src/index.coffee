> @w5/binmap > BinMap
  @w5/write
  @w5/utf8/utf8e.js
  fs > existsSync readFileSync

encode = (k)=>
  if k.constructor == String
    k = utf8e k
  k

< (fp)=>
  # 每次都重建，这样可以淘汰不存在的key
  m = new BinMap
  if existsSync fp
    prem = BinMap.load readFileSync fp
  else
    prem = m

  [
    (k)=> # get
      k = encode k
      if prem.has(k)
        v = prem.get k
        m.set k,v
        return v
      return


    (k,v)=> # set
      k = encode k
      v = encode v
      m.set k,v
      return

    => #save
      write(
        fp
        m.dump()
      )
      return
  ]

