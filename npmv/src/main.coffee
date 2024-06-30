> ./GET.js
  ./HEAD.js

METHOD = HEAD {
  # POST: ({url},env)=>
  # {pathname} = new URL(url)
  # url = env.B2_URL+pathname
  # return fetch(url)
  GET
}

export default {
  fetch: (req, env, ctx) =>
    func = METHOD[req.method]
    if func
      try
        r = await func(req,env,ctx)
      catch e
        if e instanceof Response
          return e
        console.error(e)
        if e instanceof Error
          e = e.toString()
        else
          e = JSON.stringify(e)
        return new Response(e, {status: 500})
      if r != undefined
        if r.constructor == String
          return new Response(r)
        return r
    return new Response('Not found', {status: 404})
}

