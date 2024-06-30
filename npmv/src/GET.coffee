> ./lib.js:fV > ver
  @3-/u8/u8eq.js
  ./B2.js
  ./PG.js
  ./CF.js > purgeCache

class TooBigError extends Error
  constructor: (size) ->
    super("len > "+size)
    @name = 'TooBig'

MAX_LEN = 512

export default ({url},env,ctx)=>
  pkg = new URL(url).pathname.slice(1)
  v = await ver pkg
  if not v
    return
  {npmv} = env

  exist = await npmv.get(pkg)
  if exist != null
    if await exist.text() == v
      return new Response(
        v
        headers: {
          HIT:''
        }
      )

  bin = await fV pkg,v,'.v'
  if bin.length > MAX_LEN
    throw new TooBigError MAX_LEN

  # 上传到 backblaze.com
  await B2(
    env,pkg,bin
    'text/js'
  )

  # TODO
  uid = 0

  await Promise.all([
    # 清理 cloudflare 缓存
    purgeCache(env, pkg)
    PG(
      env
      ctx
      (pg)=>
        pg.query('SELECT cdn.refresh_pkg($1,$2)', [uid, pkg])
    )
  ])

  await npmv.put(
    pkg
    v
  )
  return v
