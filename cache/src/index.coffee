> @w5/msgpack > pack
  @8n/binmap > BinMap


AsyncFunction = Object.getPrototypeOf(`async ()=>{}`).constructor

< (func)=>
  cache = new BinMap
  if func instanceof AsyncFunction
    (args...)=>
      key = pack(args)
      if cache.has(key)
        return cache.get key
      r = await func ...args
      cache.set key, r
      r
  else
    (args...)=>
      key = pack(args)
      if cache.has(key)
        return cache.get key
      r = func ...args
      cache.set key, r
      r
