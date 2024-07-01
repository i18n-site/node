> ./lib.js:fV > ver
  @3-/u8/u8eq.js
  ./B2.js
  ./PG.js
  ./CF.js > purgeCache
  @3-/token/decode.js:tokenDecode

import { Buffer } from 'node:buffer'

class TooBigError extends Error
  constructor: (size) ->
    super("len > "+size)
    @name = 'TooBig'

MAX_LEN = 512

export default ({url, headers},env,ctx)=>
  TOKEN_SK = Buffer.from(env.TOKEN_SK,'base64')
  TOKEN = headers.get('t')
  console.log TOKEN
  if not TOKEN
    return new Response(
      'headers : miss t:token'
      status: 400
    )
  token = await tokenDecode TOKEN_SK, TOKEN

  if not token
    return new Response(
      'invalid token'
      status: 401
    )

  [
    uid
    # token_id ts
  ] = token

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
