> ./index.js:Cf

< (id)=>
  new Proxy(
    {}
    get:(_,prefix)=>
      new Proxy(
        {}
        get: (_,name)=>
          (value)=>
            r = await Cf.PATCH([id,prefix,name].join('/'),{value})
            console.log prefix,name,value
            if r.value != value
              throw r
            return
      )
  )
